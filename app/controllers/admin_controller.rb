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
  end

  def index
  end

end
