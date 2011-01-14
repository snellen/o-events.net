class NationsController < ApplicationController
  # GET /nations
  # GET /nations.xml
  def index
    @nations = Nation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @nations }
    end
  end

  # GET /nations/1
  # GET /nations/1.xml
  def show
    @nation = Nation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @nation }
    end
  end

  # GET /nations/new
  # GET /nations/new.xml
  def new
    @nation = Nation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @nation }
    end
  end

  # GET /nations/1/edit
  def edit
    @nation = Nation.find(params[:id])
  end

  # POST /nations
  # POST /nations.xml
  def create
    @nation = Nation.new(params[:nation])

    respond_to do |format|
      if @nation.save
        format.html { redirect_to(@nation, :notice => 'Nation was successfully created.') }
        format.xml  { render :xml => @nation, :status => :created, :location => @nation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @nation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /nations/1
  # PUT /nations/1.xml
  def update
    @nation = Nation.find(params[:id])

    respond_to do |format|
      if @nation.update_attributes(params[:nation])
        format.html { redirect_to(@nation, :notice => 'Nation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @nation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /nations/1
  # DELETE /nations/1.xml
  def destroy
    @nation = Nation.find(params[:id])
    @nation.destroy

    respond_to do |format|
      format.html { redirect_to(nations_url) }
      format.xml  { head :ok }
    end
  end
end
