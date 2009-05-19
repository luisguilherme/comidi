class Missionario < ActiveRecord::Base
  belongs_to :estado
  has_and_belongs_to_many :sacramentos
  validates_presence_of :nome, :endereco, :bairro, :cidade, :estado, :cep, :email
  validates_uniqueness_of :email
  
end
