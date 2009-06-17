class CreateCoordenacaos < ActiveRecord::Migration
  def self.up
    create_table :coordenacaos do |t|
      t.references :missionario
      t.references :paroquia
      t.references :forania
      t.references :vicariato
      t.integer :nivel

      t.timestamps
    end
  end

  def self.down
    drop_table :coordenacaos
  end
end
