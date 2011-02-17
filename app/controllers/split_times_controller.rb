class SplitTimesController < ApplicationController
  # GET /split_times
  # GET /split_times.xml
  def index
    @split_times = SplitTime.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @split_times }
    end
  end

  # GET /split_times/1
  # GET /split_times/1.xml
  def show
    @split_time = SplitTime.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @split_time }
    end
  end

  # GET /split_times/new
  # GET /split_times/new.xml
  def new
    @split_time = SplitTime.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @split_time }
    end
  end

  # GET /split_times/1/edit
  def edit
    @split_time = SplitTime.find(params[:id])
  end

  # POST /split_times
  # POST /split_times.xml
  def create
    @split_time = SplitTime.new(params[:split_time])

    respond_to do |format|
      if @split_time.save
        format.html { redirect_to(@split_time, :notice => noticeInfo('Split time was successfully created.')) }
        format.xml  { render :xml => @split_time, :status => :created, :location => @split_time }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @split_time.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /split_times/1
  # PUT /split_times/1.xml
  def update
    @split_time = SplitTime.find(params[:id])

    respond_to do |format|
      if @split_time.update_attributes(params[:split_time])
        format.html { redirect_to(@split_time, :notice => noticeInfo('Split time was successfully updated.')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @split_time.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /split_times/1
  # DELETE /split_times/1.xml
  def destroy
    @split_time = SplitTime.find(params[:id])
    @split_time.destroy

    respond_to do |format|
      format.html { redirect_to(split_times_url) }
      format.xml  { head :ok }
    end
  end 
end
