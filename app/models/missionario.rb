class Missionario < ActiveRecord::Base
  belongs_to :estado
  belongs_to :paroquia
  has_and_belongs_to_many :sacramentos
  validates_presence_of :nome, :nome_cracha, :endereco, :bairro, :cidade, :estado, :cep
  validates_uniqueness_of :email
  validates_numericality_of :cep
end
