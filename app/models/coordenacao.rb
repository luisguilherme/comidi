class Coordenacao < ActiveRecord::Base
  belongs_to :missionario
  belongs_to :paroquia
  belongs_to :forania
  belongs_to :vicariato
end
