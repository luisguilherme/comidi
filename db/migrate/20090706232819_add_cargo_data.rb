# -*- coding: utf-8 -*-

class AddCargoData < ActiveRecord::Migration
  def self.up
    [["Coordenador Diocesano",0,false],
     ["Coordenador de Vicariato",1,false],
     ["Coordenador de Forania",2,false],
     ["Coordenador de Paróquia",3,false],
     ["Assessor Eclesial",4,false],
     ["Missionário",5,false],
     ["Coordenador Adjunto Diocesano",0,true],
     ["Coordenador Adjunto de Vicariato",1,true],
     ["Coordenador Adjunto de Forania",2,true],
     ["Coordenador Adjunto de Paróquia",3,true]].each do |data|
      nome = data[0]
      nivel = data[1]
      adjunto = data[2]
      cargo = Cargo.new(:nome => nome, :nivel => nivel, :adjunto => adjunto)
      cargo.save
    end
  end

  def self.down
    Cargo.delete_all
  end
end
