# -*- coding: utf-8 -*-
class MissionariosController < ApplicationController
  layout "comidi"
  before_filter [:authorize, :find_user]
  
  # GET /missionarios
  # GET /missionarios.xml
  def index
    ordering
    @missionarios = Missionario.find(:all, :include => :paroquia, :order => @ordering)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @missionarios }
      format.csv 
    end
  end

  def maladireta
    @missionarios = Missionario.find(:all, :order => "cep")
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @missionarios }
    end
  end

  # GET /missionarios/1
  # GET /missionarios/1.xml
  def show
    @missionario = Missionario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @missionario }
    end
  end

  # GET /missionarios/new
  # GET /missionarios/new.xml
  def new
    @missionario = Missionario.new(:cargo => Cargo.find_by_nivel(5))
    
    return unless access_control
      
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @missionario }
    end
  end

  # GET /missionarios/1/edit
  def edit
    @missionario = Missionario.find(params[:id])
    if @user.missionario != @missionario 
      return unless access_control
    end
  end

  # POST /missionarios
  # POST /missionarios.xml
  def create
    return unless access_control
    @missionario = Missionario.new(params[:missionario])
    
    #if @missionario.cargo.nivel < @nivelmin
    #  flash[:notice] = 'Cargo não foi alterado.'
    #  @missionario.cargo = Cargo.find_by_nivel(5)
    #end
    
    respond_to do |format|

      if @missionario.save
        flash[:notice] = "Missionario criado: #{@missionario.nome_cracha}"
        coordenacao(params[:missionario][:cargo_id])
        unless @user.missionario
          @user.missionario = @missionario 
          @user.save
          redirect_to :controller => :home
          return
        end
        
        format.html { redirect_to(@missionario) }
        format.xml  { render :xml => @missionario, :status => :created, :location => @missionario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @missionario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /missionarios/1
  # PUT /missionarios/1.xml
  def update
    flash[:notice] = ''
    params[:missionario][:sacramento_ids] ||= []
    @missionario = Missionario.find(params[:id])
    
    if @missionario != @user.missionario
      return unless access_control
    end

    cargo = Cargo.find(params[:missionario][:cargo_id])
    if cargo.nivel < @nivelmin
      flash[:notice] = 'Cargo não foi alterado.'
      parms[:missionario][:cargo_id] = @missionario.cargo.id
    end

    respond_to do |format|
      if @missionario.update_attributes(params[:missionario])
        coordenacao(params[:missionario][:cargo_id])
        flash[:notice] += 'Missionario was successfully updated.'
        format.html { redirect_to(@missionario) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @missionario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /missionarios/1
  # DELETE /missionarios/1.xml
  def destroy
    @missionario = Missionario.find(params[:id])
    unless @user.nivel <= 1
      flash[:notice] = 'Acesso negado'
      redirect_to(missionarios_url)
      return
    end
    @missionario.destroy

    respond_to do |format|
      format.html { redirect_to(missionarios_url) }
      format.xml  { head :ok }
    end
  end

private

  def coordenacao(id) 
    cargo = Cargo.find(id)
    nivel = cargo.nivel
    unless nivel >= 5 then
      @coordenacao = Coordenacao.find(:all, :conditions => { :missionario_id => @missionario.id }).first
      isnew = false
      if @coordenacao == nil then
        @coordenacao = Coordenacao.new 
        isnew = true
      end
      @coordenacao.nivel = nivel
      @coordenacao.missionario = @missionario
      if nivel == 3 then 
        @coordenacao.paroquia = @missionario.paroquia
      elsif nivel == 2 then
        @coordenacao.forania = @missionario.paroquia.forania
      elsif nivel == 1 then
        @coordenacao.vicariato = @missionario.paroquia.forania.vicariato
      elsif nivel == 0 then
      end
      @coordenacao.save
    end
  end

  def ordering
    ordering = session[:miss_order] || ["nome_cracha"]
    if params[:sort]
      if ordering[0].split[0] == params[:sort]
        if ordering[0][" DESC"]
          ordering[0][" DESC"] = ""
        else
          ordering[0] += " DESC"
        end
      else
        ordering.unshift(params[:sort]).uniq!
      end
    end
    session[:miss_order] = ordering.uniq
    @ordering = ""
    session[:miss_order].each { |f| @ordering += f + ", " }
    @ordering = @ordering[0..-3]
  end

  def authorize
    unless session[:usuario_id]
      session[:original_uri] = request.request_uri
      flash[:notice] = "Favor fazer login"
      redirect_to :controller => :admin, :action => :login
    end
  end


  def find_user
    @user = Usuario.find(session[:usuario_id])
    @nivelmin = 5
  end

  def access_control
    if @user.missionario && @user.nivel > 1 && @user.missionario.cargo.nivel >= 5
      flash[:notice] = "Acesso negado" 
      redirect_to request.referrer || { :controller => :home }
      return false
    elsif @user.missionario && @user.nivel > 1 && @missionario.cargo.nivel <= @user.missionario.cargo.nivel 
    end
    
    @nivelmin = 5
    if @user.nivel <= 1 
      @nivelmin = 0
    elsif @user.missionario 
      @nivelmin = @user.missionario.cargo.nivel+1
    end
    return true
  end

end
