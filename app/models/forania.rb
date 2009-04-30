class Forania < ActiveRecord::Base
  belongs_to :vicariato
  has_many :paroquias
end
