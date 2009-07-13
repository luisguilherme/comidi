require 'digest/sha1'

class Usuario < ActiveRecord::Base
  belongs_to :missionario

  validates_presence_of :login
  validates_uniqueness_of :login
  
  attr_accessor :password_confirmation
  validates_confirmation_of :password

  validate :senha_nao_nula

  
  def self.autentica(login, password)
    usuario = self.find_by_login(login)
    if usuario
      expected_password = encrypted_password(password, usuario.salt)
      if usuario.hash_senha != expected_password 
        usuario = nil
      end
    end
    usuario
  end


  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hash_senha = Usuario.encrypted_password(self.password, self.salt)
  end
  
private
  
  def senha_nao_nula
    errors.add_to_base("Falta senha") if hash_senha.blank?
  end

  def create_new_salt 
    self.salt = self.object_id.to_s + rand.to_s
  end

  def self.encrypted_password(password,salt) 
    string_to_hash = password + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end


end
