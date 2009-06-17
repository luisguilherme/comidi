class WelcomeController < ApplicationController
  def index
    @num_missionarios = Missionario.count
    @coordenacao = Coordenacao.find(:all, :conditions => { :nivel => 0 })
    @coordenadores = []
    @coordenacao.each do |line| 
      @coordenadores << line.missionario
    end
  end
end
