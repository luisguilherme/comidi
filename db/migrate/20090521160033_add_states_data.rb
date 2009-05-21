class AddStatesData < ActiveRecord::Migration
  def self.up
    csvFile = File.new(RAILS_ROOT + "/states","r")
    csvFile.each_line do |line| 
      data = line.split(',')
      sigla = data[0]
      nome = data[1]
      state = Estado.new(:nome => nome, :sigla => sigla)  
      state.save
    end
  end

  def self.down
    Estado.delete_all
  end
end
