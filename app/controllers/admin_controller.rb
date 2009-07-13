# -*- coding: utf-8 -*-
class AdminController < ApplicationController
  def login
    session[:usuario_id] = nil
    if request.post?
      usuario = Usuario.autentica(params[:login],params[:password])
      if usuario 
        session[:usuario_id] = usuario.id
        redirect_to(:action => "index")
      else
        flash.now[:notice] = "Usuário ou senha inválidos"
      end
    end
  end

  def logout
    session[:usuario_id] = nil
    redirect_to :controller => 'welcome'
  end

  def index
    @num_missionarios = Missionario.count
    threshold = 4
    cargos = Cargo.find(:all, :conditions => { :nivel => 0..threshold })
    @coordenadores = Missionario.find(:all, :conditions => { :cargo_id => cargos })
  end

end
