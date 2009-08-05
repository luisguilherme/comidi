class AddMissionarioIdToTelefone < ActiveRecord::Migration
  def self.up
    add_column :telefones, :missionario_id, :integer
  end

  def self.down
    remove_column :telefones, :missionario_id
  end
end
