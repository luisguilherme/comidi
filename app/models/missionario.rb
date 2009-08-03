class Missionario < ActiveRecord::Base
  belongs_to :estado
  belongs_to :paroquia
  belongs_to :cargo
  has_and_belongs_to_many :sacramentos
  validates_presence_of :nome, :nome_cracha, :endereco, :bairro, :cidade, :estado, :cep, :numero
  validates_uniqueness_of :email, :allow_blank => true
  validates_numericality_of :cep
  has_one :usuario
  def editable_by(user)
    user.missionario == self || user.nivel <= 1
  end
end
