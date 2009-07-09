class AddNivelToUsuario < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :nivel, :integer
    Usuario.find(:all).each do |usuario|
      usuario.nivel = 2
      usuario.save
    end
  end

  def self.down
    remove_column :usuarios, :nivel
  end
end
