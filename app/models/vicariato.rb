class Vicariato < ActiveRecord::Base
  has_many :foranias
  has_many :coordenacaos
  has_many :coordenadores, :through => :coordenacaos, :source => :missionario

  def count_missionarios 
    @foranias = this.foranias
    count = 0
    @foranias.each do |forania|
      count += forania.missionarios.count
    end
  end
end
