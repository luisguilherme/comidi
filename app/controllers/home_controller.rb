# -*- coding: utf-8 -*-
class HomeController < ApplicationController
  def index
    @user = Usuario.find(session[:usuario_id])
    if @user.missionario == nil 
      redirect_to :controller => :missionarios, :action => :new
    end
    @missionario = @user.missionario
  end
  
  def authorize 
    user = Usuario.find_by_id(session[:usuario_id])
    unless user
      #flash[:notice] = "Faça login para acessar o sistema"
      redirect_to :controller => :welcome
    end
  end
end
