class Paroquia < ActiveRecord::Base
  belongs_to :forania
  has_many :missionarios

  def nome_e_bairro
    "#{bairro} - #{nome}"
  end
  def to_s
    nome_e_bairro
  end
end
