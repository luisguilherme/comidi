class CreateParoquias < ActiveRecord::Migration
  def self.up
    create_table :paroquias do |t|
      t.string :nome
      t.references :forania
      t.string :bairro
      t.integer :num_de_comunidades

      t.timestamps
    end
  end

  def self.down
    drop_table :paroquias
  end
end
