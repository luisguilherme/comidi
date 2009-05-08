class Missionario < ActiveRecord::Base
  belongs_to :estado
  has_and_belongs_to_many :sacramentos
  
end
