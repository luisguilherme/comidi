class AddOrdemToSacramentos < ActiveRecord::Migration
  def self.up
    Sacramento.create(:nome => "Ordem")
  end

  def self.down
    Sacramento.delete_all(:nome => "Ordem")
  end
end
