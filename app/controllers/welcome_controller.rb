class WelcomeController < ApplicationController
  layout "comidi"
  def index
    @coordenador = Coordenacao.find(:first, :conditions => { :nivel => 0 })
  end
  def authorize
  end
end
