class CreateMissionarioSacramentoJoinTable < ActiveRecord::Migration
  def self.up
    create_table (:missionarios_sacramentos, :id => false) do |t|
      t.integer :missionario_id
      t.integer :sacramento_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :missionarios_sacramentos
  end
end
