class AddTelefoneToMissionario < ActiveRecord::Migration
  def self.up
    add_column :missionarios, :ddd_casa, :string
    add_column :missionarios, :telefone_casa, :string
    add_column :missionarios, :ddd_celular, :string
    add_column :missionarios, :telefone_celular, :string
    add_column :missionarios, :ddd_trabalho, :string
    add_column :missionarios, :telefone_trabalho, :string
  end

  def self.down
    remove_column :missionarios, :telefone_trabalho
    remove_column :missionarios, :ddd_trabalho
    remove_column :missionarios, :telefone_celular
    remove_column :missionarios, :ddd_celular
    remove_column :missionarios, :telefone_casa
    remove_column :missionarios, :ddd_casa
  end
end
