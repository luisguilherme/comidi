# -*- coding: utf-8 -*-
class AddSacramentoData < ActiveRecord::Migration
  def self.up
    ["Batismo","Eucaristia","Crisma","Matrimônio"].each do |nome|
      Sacramento.create(:nome => nome)
    end
  end

  def self.down
    Sacramento.delete_all
  end
end
