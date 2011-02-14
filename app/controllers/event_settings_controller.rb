class EventSettingsController < ApplicationController
  # GET /event_settings
  # GET /event_settings.xml
  def index
    @event_settings = EventSetting.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @event_settings }
    end
  end

  # GET /event_settings/1
  # GET /event_settings/1.xml
  def show
    @event_setting = EventSetting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event_setting }
    end
  end

  # GET /event_settings/new
  # GET /event_settings/new.xml
  def new
    @event_setting = EventSetting.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event_setting }
    end
  end

  # GET /event_settings/1/edit
  def edit
    @event_setting = EventSetting.find(params[:id])
  end

  # POST /event_settings
  # POST /event_settings.xml
  def create
    @event_setting = EventSetting.new(params[:event_setting])

    respond_to do |format|
      if @event_setting.save
        format.html { redirect_to(@event_setting, :notice => 'Event setting was successfully created.') }
        format.xml  { render :xml => @event_setting, :status => :created, :location => @event_setting }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event_setting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /event_settings/1
  # PUT /event_settings/1.xml
  def update
    @event_setting = EventSetting.find(params[:id])

    respond_to do |format|
      if @event_setting.update_attributes(params[:event_setting])
        format.html { redirect_to(@event_setting, :notice => 'Event setting was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event_setting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /event_settings/1
  # DELETE /event_settings/1.xml
  def destroy
    @event_setting = EventSetting.find(params[:id])
    @event_setting.destroy

    respond_to do |format|
      format.html { redirect_to(event_settings_url) }
      format.xml  { head :ok }
    end
  end 
end
