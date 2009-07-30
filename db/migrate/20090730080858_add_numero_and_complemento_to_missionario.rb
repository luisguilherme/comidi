class AddNumeroAndComplementoToMissionario < ActiveRecord::Migration
  def self.up
    add_column :missionarios, :numero, :string
    add_column :missionarios, :complemento, :string

    Missionario.find(:all).each do |m|
      sepv = m.endereco.split(',')
      l = sepv[0]
      nc = sepv[1]
      nc.strip! if nc != nil
      n = nc
      if !nc.blank?
        nsep = nc.split(' ',2)
        n = nsep[0]
        c = nsep[1]
      end
      m.endereco = l
      m.numero = n || ""
      m.complemento = c || ""
      m.save
    end
  end

  def self.down
    Missionario.find(:all).each do |m|
      novo_endereco = m.endereco
      novo_endereco += ", " + m.numero unless m.numero.blank?
      novo_endereco += " " + m.complemento unless m.complemento.blank?
      m.endereco = novo_endereco
      m.save
    end
    
    remove_column :missionarios, :complemento
    remove_column :missionarios, :numero
  end
end
