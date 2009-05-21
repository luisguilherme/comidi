class Paroquia < ActiveRecord::Base
  belongs_to :forania
  has_many :missionarios

  def nome_e_bairro
    "#{nome} - #{bairro}"
  end
end
