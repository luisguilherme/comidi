class CreateVicariatos < ActiveRecord::Migration
  def self.up
    create_table :vicariatos do |t|
      t.string :nome

      t.timestamps
    end
  end

  def self.down
    drop_table :vicariatos
  end
end
