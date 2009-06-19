class MissionariosController < ApplicationController
  # GET /missionarios
  # GET /missionarios.xml
  def index
    @missionarios = Missionario.find(:all)

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
    @missionario = Missionario.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @missionario }
    end
  end

  # GET /missionarios/1/edit
  def edit
    @missionario = Missionario.find(params[:id])
  end

  # POST /missionarios
  # POST /missionarios.xml
  def create
    @missionario = Missionario.new(params[:missionario])
    
    respond_to do |format|
      if @missionario.save
        coordenacao(params[:missionario][:nivel].to_i)
        flash[:notice] = "Missionario was successfully created. #{@message}"
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
    params[:missionario][:sacramento_ids] ||= []
    @missionario = Missionario.find(params[:id])
    

    respond_to do |format|
      if @missionario.update_attributes(params[:missionario])
        coordenacao(params[:missionario][:nivel].to_i)
        flash[:notice] = 'Missionario was successfully updated.'
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
    @missionario.destroy

    respond_to do |format|
      format.html { redirect_to(missionarios_url) }
      format.xml  { head :ok }
    end
  end

  def coordenacao(id) 
    unless id >= 4 then
      @coordenacao = Coordenacao.find(:all, :conditions => { :missionario_id => @missionario.id }).first
      isnew = false
      if @coordenacao == nil then
        @coordenacao = Coordenacao.new 
        isnew = true
      end
      @coordenacao.nivel = id
      @coordenacao.missionario = @missionario
      if id == 3 then 
        @coordenacao.paroquia = @missionario.paroquia
      elsif id == 2 then
        @coordenacao.forania = @missionario.paroquia.forania
      elsif id == 1 then
        @coordenacao.vicariato = @missionario.paroquia.forania.vicariato
      elsif id == 0 then
      end
      @coordenacao.save
    end
  end
    
end
