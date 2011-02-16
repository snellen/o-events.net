class EventsController < ApplicationController
  skip_before_filter :authorize, :only =>[:index, :show]
  
  # GET /events
  # GET /events.xml
  def index
    if(params[:user_id])
      @events = User.find(params[:user_id]).events
    else
      @events = Event.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = nil
    if params[:year] and params[:slug]
      fromDate = Time.local(Integer(params[:year]), 1, 1)
      toDate = Time.local(Integer(params[:year]), 12, 31)
      events = Event.where(:slug => params[:slug], :start_date => (fromDate)..(toDate))
      if events.size > 0
        @event = events.first
      end
    end
    if !@event
      @event = Event.find(params[:id])
    end
    @title = @event.name
    session[:event_tab] = {:tab => @title, :url => event_url(@event)}

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end
=begin 
  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    @title =  @event.name
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end
=end
end
