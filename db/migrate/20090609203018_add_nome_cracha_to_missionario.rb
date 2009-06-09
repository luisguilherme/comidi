class AddNomeCrachaToMissionario < ActiveRecord::Migration
  def self.up
    add_column :missionarios, :nome_cracha, :string
  end

  def self.down
    remove_column :missionarios, :nome_cracha
  end
end
