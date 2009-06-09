class RemoveEstadoCivilFromMissionario < ActiveRecord::Migration
  def self.up
    remove_column :missionarios, :estado_civil
  end

  def self.down
    add_column :missionarios, :estado_civil, :string
  end
end
