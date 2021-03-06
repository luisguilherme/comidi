class Forania < ActiveRecord::Base
  belongs_to :vicariato
  has_many :paroquias
  has_many :missionarios, :through => :paroquias
  has_many :coordenacaos
  has_many :coordenadores, :through => :coordenacaos, :source => :missionario
end
