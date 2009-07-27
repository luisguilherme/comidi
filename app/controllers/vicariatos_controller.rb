class VicariatosController < ApplicationController
  # GET /vicariatos
  # GET /vicariatos.xml
  def index
    @vicariatos = Vicariato.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vicariatos }
    end
  end

  # GET /vicariatos/1
  # GET /vicariatos/1.xml
  def show
    @vicariato = Vicariato.find(params[:id])
    @coordenadores = @vicariato.coordenadores
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vicariato }
    end
  end

  # GET /vicariatos/new
  # GET /vicariatos/new.xml
  def new
    @vicariato = Vicariato.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vicariato }
    end
  end

  # GET /vicariatos/1/edit
  def edit
    @vicariato = Vicariato.find(params[:id])
  end

  # POST /vicariatos
  # POST /vicariatos.xml
  def create
    @vicariato = Vicariato.new(params[:vicariato])

    respond_to do |format|
      if @vicariato.save
        flash[:notice] = 'Vicariato was successfully created.'
        format.html { redirect_to(@vicariato) }
        format.xml  { render :xml => @vicariato, :status => :created, :location => @vicariato }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vicariato.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vicariatos/1
  # PUT /vicariatos/1.xml
  def update
    @vicariato = Vicariato.find(params[:id])

    respond_to do |format|
      if @vicariato.update_attributes(params[:vicariato])
        flash[:notice] = 'Vicariato was successfully updated.'
        format.html { redirect_to(@vicariato) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vicariato.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vicariatos/1
  # DELETE /vicariatos/1.xml
  def destroy
    @vicariato = Vicariato.find(params[:id])
    @vicariato.destroy

    respond_to do |format|
      format.html { redirect_to(vicariatos_url) }
      format.xml  { head :ok }
    end
  end
end
