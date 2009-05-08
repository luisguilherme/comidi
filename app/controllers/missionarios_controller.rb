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
        flash[:notice] = 'Missionario was successfully created.'
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
    @missionario = Missionario.find(params[:id])

    respond_to do |format|
      if @missionario.update_attributes(params[:missionario])
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
end
