class ForaniasController < ApplicationController
  # GET /foranias
  # GET /foranias.xml
  def index
    @foranias = Forania.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @foranias }
    end
  end

  # GET /foranias/1
  # GET /foranias/1.xml
  def show
    @forania = Forania.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @forania }
    end
  end

  # GET /foranias/new
  # GET /foranias/new.xml
  def new
    @forania = Forania.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @forania }
    end
  end

  # GET /foranias/1/edit
  def edit
    @forania = Forania.find(params[:id])
  end

  # POST /foranias
  # POST /foranias.xml
  def create
    @forania = Forania.new(params[:forania])

    respond_to do |format|
      if @forania.save
        flash[:notice] = 'Forania was successfully created.'
        format.html { redirect_to(@forania) }
        format.xml  { render :xml => @forania, :status => :created, :location => @forania }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @forania.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /foranias/1
  # PUT /foranias/1.xml
  def update
    @forania = Forania.find(params[:id])

    respond_to do |format|
      if @forania.update_attributes(params[:forania])
        flash[:notice] = 'Forania was successfully updated.'
        format.html { redirect_to(@forania) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @forania.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /foranias/1
  # DELETE /foranias/1.xml
  def destroy
    @forania = Forania.find(params[:id])
    @forania.destroy

    respond_to do |format|
      format.html { redirect_to(foranias_url) }
      format.xml  { head :ok }
    end
  end
end
