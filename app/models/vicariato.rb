class Vicariato < ActiveRecord::Base
  has_many :foranias

  def count_missionarios 
    @foranias = this.foranias
    count = 0
    @foranias.each do |forania|
      count += forania.missionarios.count
    end
  end
end
