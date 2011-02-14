class ChipsController < ApplicationController
  # GET /chips
  # GET /chips.xml
  def index
    @chips = Chip.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @chips }
    end
  end

  # GET /chips/1
  # GET /chips/1.xml
  def show
    @chip = Chip.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chip }
    end
  end

  # GET /chips/new
  # GET /chips/new.xml
  def new
    @chip = Chip.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @chip }
    end
  end

  # GET /chips/1/edit
  def edit
    @chip = Chip.find(params[:id])
  end

  # POST /chips
  # POST /chips.xml
  def create
    @chip = Chip.new(params[:chip])

    respond_to do |format|
      if @chip.save
        format.html { redirect_to(@chip, :notice => 'Chip was successfully created.') }
        format.xml  { render :xml => @chip, :status => :created, :location => @chip }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @chip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /chips/1
  # PUT /chips/1.xml
  def update
    @chip = Chip.find(params[:id])

    respond_to do |format|
      if @chip.update_attributes(params[:chip])
        format.html { redirect_to(@chip, :notice => 'Chip was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chips/1
  # DELETE /chips/1.xml
  def destroy
    @chip = Chip.find(params[:id])
    @chip.destroy

    respond_to do |format|
      format.html { redirect_to(chips_url) }
      format.xml  { head :ok }
    end
  end 
end
