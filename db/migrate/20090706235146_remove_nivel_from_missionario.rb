class RemoveNivelFromMissionario < ActiveRecord::Migration
  def self.up
    remove_column :missionarios, :nivel
  end

  def self.down
    add_column :missionarios, :nivel, :integer
  end
end
