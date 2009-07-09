class CreateUsuarios < ActiveRecord::Migration
  def self.up
    create_table :usuarios do |t|
      t.string :login
      t.string :hash_senha
      t.string :salt
      t.references :missionario

      t.timestamps
    end
  end

  def self.down
    drop_table :usuarios
  end
end
