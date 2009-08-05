class ChangeNumeroTypeToStringInTelefones < ActiveRecord::Migration
  def self.up
    change_column :telefones, :numero, :string
  end

  def self.down
    change_column :telefones, :numero, :integer
  end
end
