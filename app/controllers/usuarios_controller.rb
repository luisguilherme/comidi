# -*- coding: utf-8 -*-
class UsuariosController < ApplicationController
  before_filter :authorize, :except => [:new, :create]
  # GET /usuarios
  # GET /usuarios.xml
  def index
    @usuarios = Usuario.find(:all, :order => :login)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @usuarios }
    end
  end

  # GET /usuarios/1
  # GET /usuarios/1.xml
  def show
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @usuario }
    end
  end

  # GET /usuarios/new
  # GET /usuarios/new.xml
  def new
    @usuario = Usuario.new(:nivel => 2)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @usuario }
    end
  end

  # GET /usuarios/1/edit
  def edit
    @usuario = Usuario.find(params[:id])
    unless (@usuario.editable_by(Usuario.find(session[:usuario_id]))) 
      flash[:notice] = 'Acesso negado'
      redirect_to(:action => :index)
    end
  end

  # POST /usuarios
  # POST /usuarios.xml
  def create
    @usuario = Usuario.new(params[:usuario])
    user = session[:usuario_id]

    flash[:notice] = ''
    
    if !user #usuario ainda não foi criado, está criando a si
      @usuario.nivel = 2 #não pode se criar com poderes
    else
      usuario = Usuario.find(session[:usuario_id])
      if !usuario || usuario.nivel == 2 # não pode criar outros usuários
        flash[:notice] = 'Acesso negado'
        redirect_to(:action => :index) #mudar depois
      elsif usuario.nivel >= @usuario.nivel
        flash[:notice] = 'Usuário criado com nível mais baixo do que o pedido <br />'
        @usuario.nivel = usuario.nivel + 1 #não pode criar com tantos poderes quanto si mesmo
      end
    end
    
    respond_to do |format|
      if @usuario.save
        flash[:notice] += 'Usuario #{@usuario.login} was successfully created.'
        session[:usuario_id] = @usuario.id unless session[:usuario_id] 
        format.html { redirect_to(:controller => :home) }
        format.xml  { render :xml => @usuario, :status => :created, :location => @usuario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /usuarios/1
  # PUT /usuarios/1.xml
  def update
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      if @usuario.update_attributes(params[:usuario])
        flash[:notice] = 'Usuario #{@usuario.login} was successfully updated.'
        format.html { redirect_to(:action => :index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.xml
  def destroy
    @usuario = Usuario.find(params[:id])
    unless (@usuario.editable_by(Usuario.find(session[:usuario_id]))) 
      flash[:notice] = 'Acesso negado'
      redirect_to(usuarios_url)
      return
    end
    @usuario.destroy

    respond_to do |format|
      format.html { redirect_to(usuarios_url) }
      format.xml  { head :ok }
    end
  end

  def authorize
    #Este é mais sensível
    user = Usuario.find_by_id(session[:usuario_id])
    if user and user.nivel > 1
      flash[:notice] = "Acesso proibido"
      redirect_to :controller => :welcome
      return
    end
    unless user and user.nivel <= 1
      flash[:notice] = "Faça login"
      redirect_to :controller => :admin, :action => :login
    end
  end
end
