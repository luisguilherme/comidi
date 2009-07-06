class CreateCargos < ActiveRecord::Migration
  def self.up
    create_table :cargos do |t|
      t.string :nome
      t.integer :nivel
      t.boolean :adjunto

      t.timestamps
    end
  end

  def self.down
    drop_table :cargos
  end
end
