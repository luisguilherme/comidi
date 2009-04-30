class ParoquiasController < ApplicationController
  # GET /paroquias
  # GET /paroquias.xml
  def index
    @paroquias = Paroquia.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @paroquias }
    end
  end

  # GET /paroquias/1
  # GET /paroquias/1.xml
  def show
    @paroquia = Paroquia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @paroquia }
    end
  end

  # GET /paroquias/new
  # GET /paroquias/new.xml
  def new
    @paroquia = Paroquia.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @paroquia }
    end
  end

  # GET /paroquias/1/edit
  def edit
    @paroquia = Paroquia.find(params[:id])
  end

  # POST /paroquias
  # POST /paroquias.xml
  def create
    @paroquia = Paroquia.new(params[:paroquia])

    respond_to do |format|
      if @paroquia.save
        flash[:notice] = 'Paroquia was successfully created.'
        format.html { redirect_to(@paroquia) }
        format.xml  { render :xml => @paroquia, :status => :created, :location => @paroquia }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @paroquia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /paroquias/1
  # PUT /paroquias/1.xml
  def update
    @paroquia = Paroquia.find(params[:id])

    respond_to do |format|
      if @paroquia.update_attributes(params[:paroquia])
        flash[:notice] = 'Paroquia was successfully updated.'
        format.html { redirect_to(@paroquia) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @paroquia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /paroquias/1
  # DELETE /paroquias/1.xml
  def destroy
    @paroquia = Paroquia.find(params[:id])
    @paroquia.destroy

    respond_to do |format|
      format.html { redirect_to(paroquias_url) }
      format.xml  { head :ok }
    end
  end
end
