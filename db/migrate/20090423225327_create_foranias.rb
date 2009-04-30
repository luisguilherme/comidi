class CreateForanias < ActiveRecord::Migration
  def self.up
    create_table :foranias do |t|
      t.references :vicariato
      t.integer :numero

      t.timestamps
    end
  end

  def self.down
    drop_table :foranias
  end
end
