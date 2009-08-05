class Telefone < ActiveRecord::Base
  validates_presence_of :ddd, :numero
  belongs_to :missionario
end
