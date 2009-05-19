class AddParoquiaToMissionario < ActiveRecord::Migration
  def self.up
    add_column :missionarios, :paroquia_id, :integer
  end

  def self.down
    remove_column :missionarios, :paroquia
  end
end
