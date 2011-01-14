class StartTimesController < ApplicationController
  # GET /start_times
  # GET /start_times.xml
  def index
    @start_times = StartTime.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @start_times }
    end
  end

  # GET /start_times/1
  # GET /start_times/1.xml
  def show
    @start_time = StartTime.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @start_time }
    end
  end

  # GET /start_times/new
  # GET /start_times/new.xml
  def new
    @start_time = StartTime.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @start_time }
    end
  end

  # GET /start_times/1/edit
  def edit
    @start_time = StartTime.find(params[:id])
  end

  # POST /start_times
  # POST /start_times.xml
  def create
    @start_time = StartTime.new(params[:start_time])

    respond_to do |format|
      if @start_time.save
        format.html { redirect_to(@start_time, :notice => 'Start time was successfully created.') }
        format.xml  { render :xml => @start_time, :status => :created, :location => @start_time }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @start_time.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /start_times/1
  # PUT /start_times/1.xml
  def update
    @start_time = StartTime.find(params[:id])

    respond_to do |format|
      if @start_time.update_attributes(params[:start_time])
        format.html { redirect_to(@start_time, :notice => 'Start time was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @start_time.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /start_times/1
  # DELETE /start_times/1.xml
  def destroy
    @start_time = StartTime.find(params[:id])
    @start_time.destroy

    respond_to do |format|
      format.html { redirect_to(start_times_url) }
      format.xml  { head :ok }
    end
  end
end
