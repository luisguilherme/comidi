class CreateTelefonesFromStaticData < ActiveRecord::Migration
  def self.up
    Missionario.find(:all).each do |m|
      [["Residencial","casa"],
       ["Comercial","trabalho"],
       ["Celular","celular"]].each do |f|
        unless m.send("telefone_#{f[1]}").blank?
          Telefone.create(:ddd => m.send("ddd_#{f[1]}"),
                          :numero => m.send("telefone_#{f[1]}"),
                          :tipo_telefone => f[0],
                          :missionario_id => m.id)
        end
      end
    end
  end

  def self.down
    Telefone.delete_all
  end
end
