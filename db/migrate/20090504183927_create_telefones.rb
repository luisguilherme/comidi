class CreateTelefones < ActiveRecord::Migration
  def self.up
    create_table :telefones do |t|
      t.string :tipo_telefone
      t.integer :ddd
      t.integer :numero

      t.timestamps
    end
  end

  def self.down
    drop_table :telefones
  end
end
