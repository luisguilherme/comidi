class CreateSacramentos < ActiveRecord::Migration
  def self.up
    create_table :sacramentos do |t|
      t.string :nome

      t.timestamps
    end
  end

  def self.down
    drop_table :sacramentos
  end
end
