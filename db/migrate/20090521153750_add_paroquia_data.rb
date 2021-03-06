# -*- coding: utf-8 -*-
class AddParoquiaData < ActiveRecord::Migration
  def self.up
    ace = "ÁÀÃÂÄÉÈÊËÍÌÎÏÓÒÕÔÖÚÙÛÜÝÇ";
    sac = "áàãâäéèêëíìîïóòõôöúùûüýç"
    csvFile = File.new(RAILS_ROOT + "/paroquias.csv","r")
    csvFile.each_line do |line| 
      data = line.split(',')
      vicariato = data[0].capitalize.tr(ace,sac)
      forania = data[1].to_i
      bairro = data[2].delete('"').capitalize.tr(ace,sac)
      paroquia = data[3].delete('"')
      ncom = data[4].to_i 
      
      vdata = Vicariato.find(:first, :conditions => { :nome => vicariato })
      if vdata == nil then
        vdata = Vicariato.new(:nome => vicariato)
        vdata.save
      end

      fdata = Forania.find(:first, :conditions => 
                           { :numero => forania, :vicariato_id => vdata.id })
      if fdata == nil then
        fdata = Forania.new(:numero => forania, :vicariato_id => vdata.id)
        fdata.save
      end

      pdata = Paroquia.find(:first, :conditions => 
                            { :nome => paroquia, :forania_id => fdata.id })
      if pdata == nil then
        pdata = Paroquia.new(:nome => paroquia, :forania_id => fdata.id, 
                             :bairro => bairro, :num_de_comunidades => ncom)
        pdata.save
      end
    end

  end

  def self.down
    Paroquia.delete_all
    Forania.delete_all
    Vicariato.delete_all
  end
end

