class CreateMissionarios < ActiveRecord::Migration
  def self.up
    create_table :missionarios do |t|
      t.string :nome
      t.date :nascimento
      t.string :endereco
      t.string :bairro
      t.string :cidade
      t.references :estado
      t.string :cep
      t.string :email
      t.string :estado_civil
      t.string :profissao
      t.text :movimentos_pastorais

      t.timestamps
    end
  end

  def self.down
    drop_table :missionarios
  end
end
