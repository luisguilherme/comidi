class AddAtividadesToMissionario < ActiveRecord::Migration
  def self.up
    add_column :missionarios, :atividades, :text
  end

  def self.down
    remove_column :missionarios, :atividades
  end
end
