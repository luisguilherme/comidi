class WelcomeController < ApplicationController
  def index
    @num_missionarios = Missionario.count
    threshold = 0
    @coordenacao = Coordenacao.find(:all, :conditions => { :nivel => 0..4 }, :order => "nivel ASC" )
    @coordenadores = []
    @coordenacao.each do |line| 
      @coordenadores << line.missionario
    end
  end
end
