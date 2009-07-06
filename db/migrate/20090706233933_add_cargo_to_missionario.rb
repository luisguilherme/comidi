class AddCargoToMissionario < ActiveRecord::Migration
  def self.up
    add_column :missionarios, :cargo_id, :integer
    Missionario.find(:all).each do |missionario|
      if missionario.nivel != nil then
        cargo = Cargo.find(:first, :conditions => { :nivel => missionario.nivel } ) 
      else
        cargo = Cargo.find(:first, :conditions => { :nivel => 5 } )
      end
      missionario.cargo_id = cargo.id
      missionario.save
    end
  end
  
  def self.down
    remove_column :missionarios, :cargo_id
  end
end
