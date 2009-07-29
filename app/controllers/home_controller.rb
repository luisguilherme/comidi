class HomeController < ApplicationController
  def index
    user = Usuario.find(session[:usuario_id])
    if user.missionario == nil 
      redirect_to :controller => :missionarios, :action => :new
    end
    @missionario = user.missionario
  end

end
