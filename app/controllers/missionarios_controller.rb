# -*- coding: utf-8 -*-
class MissionariosController < ApplicationController
  layout "comidi"
  before_filter [:authorize, :find_user ]

  # GET /missionarios
  # GET /missionarios.xml
  def index
    ordering
    set_conditions
    @missionarios = Missionario.find(:all, :include => :paroquia, :order => @ordering, :conditions => @conditions )

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
    2.times { @missionario.telefones.build(:ddd => 21) }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @missionario }
    end
  end

  # GET /missionarios/1/edit
  def edit
    @missionario = Missionario.find(params[:id])
    return unless access_control
    @missionario.telefones.build(:ddd => 21)
  end

  # POST /missionarios
  # POST /missionarios.xml
  def create
    @missionario = Missionario.new(params[:missionario])
    return unless access_control

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
    params[:missionario][:existe_telefone_attributes] ||= { }

    @missionario = Missionario.find(params[:id])

    return unless access_control

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
  end


  def set_conditions
    @conditions = { }
    if params[:paroquia_id]
      @conditions[:paroquia_id] = params[:paroquia_id]
    elsif params[:forania_id]
      forania = Forania.find(params[:forania_id])
      @conditions[:paroquia_id] = forania.paroquias.map { |p| p.id }
    elsif params[:vicariato_id]
      vicariato = Vicariato.find(params[:vicariato_id])
      @conditions[:paroquia_id] = vicariato.paroquias.map { |p| p.id }
    end
  end




  def access_control
    if @user.missionario == nil || @user.missionario == @missionario || @user.nivel <= 1
    elsif @missionario.cargo.nivel <= @user.missionario.cargo.nivel  ||
        @user.missionario.cargo.nivel >= 5
      flash[:notice] = "Acesso negado"
      redirect_to request.referrer || { :controller => :home }
      return false
    end

    @nivelmin = 5
    if @user.nivel <= 1
      @nivelmin = 0
    elsif @user.missionario
      @nivelmin = @user.missionario.cargo.nivel
    end
    return true
  end

end
