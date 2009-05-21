class Forania < ActiveRecord::Base
  belongs_to :vicariato
  has_many :paroquias
  has_many :missionarios, :through => :paroquias
end
