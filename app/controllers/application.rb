# -*- coding: utf-8 -*-
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :authorize, :except => [:login, :logout] 

  helper :all # include all helpers, all the time

  session :session_key => '_comidi_session_id'
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => '016c12da86113f2c8ffa5d9b18d46de3'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  protected
  def authorize
    user = Usuario.find_by_id(session[:usuario_id])
    if user and user.nivel > 1
      flash[:notice] = "Acesso proibido para o seu usuário"
      uri = request.referrer
      redirect_to (uri || {:controller => :welcome})
      return
    end
    unless user and user.nivel <= 1
      session[:original_uri] = request.request_uri
      flash[:notice] = "Faça login"
      redirect_to :controller => :admin, :action => :login
    end

  end
  
end
