class Paroquia < ActiveRecord::Base
  belongs_to :forania

  def nome_e_bairro
    "#{nome} - #{bairro}"
  end
end
