class AddNivelToMissionario < ActiveRecord::Migration
  def self.up
    add_column :missionarios, :nivel, :integer
  end

  def self.down
    remove_column :missionarios, :nivel
  end
end
