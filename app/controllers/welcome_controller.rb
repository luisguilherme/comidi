class WelcomeController < ApplicationController
  layout "comidi"
  def index
    @num = Missionario.count
    @coordenador = Coordenacao.find(:first, :conditions => { :nivel => 0 })
  end
  def authorize
  end
end
