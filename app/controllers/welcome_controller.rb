class WelcomeController < ApplicationController
  def index
    @num_missionarios = Missionario.count
    threshold = 1
    @coordenacao = Coordenacao.find(:all, :conditions => { :nivel => 0..threshold }, :order => "nivel ASC" )
    @coordenadores = []
    @coordenacao.each do |line| 
      @coordenadores << line.missionario
    end
  end
  def authorize
  end
end
