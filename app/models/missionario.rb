class Missionario < ActiveRecord::Base
  belongs_to :estado
  belongs_to :paroquia
  belongs_to :cargo
  has_many :telefones, :dependent => :destroy
  has_and_belongs_to_many :sacramentos
  validates_presence_of :nome, :nome_cracha, :endereco, :bairro, :cidade, :estado, :cep, :numero, :nascimento, :paroquia
  validates_uniqueness_of :email, :allow_blank => true
  validate :telefones_not_blank
  validates_associated :telefones

  after_update :save_telefones

  validates_numericality_of :cep
  has_one :usuario

  def novo_telefone_attributes=(telefone_attributes)
    telefone_attributes.each do |attributes|
      telefones.build(attributes) unless attributes[:numero].blank?
    end
  end

  def existe_telefone_attributes=(telefone_attributes)
    telefones.reject(&:new_record?).each do |telefone|
      attributes = telefone_attributes[telefone.id.to_s]
      if attributes
        telefone.attributes = attributes
      else
        telefones.delete(telefone)
      end
    end
  end

  def save_telefones
    telefones.each do |telefone|
      telefone.save(false)
    end
  end

  protected
  def telefones_not_blank
    if telefones.size == 0
      errors.add(:telefones, ": é preciso ter um válido pelo menos ")
      telefones.build(:ddd => 21)
    end
  end

  private
  def editable_by(user)
    user.missionario == self || user.nivel <= 1
  end
end
