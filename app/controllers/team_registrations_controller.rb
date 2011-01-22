class TeamRegistrationsController < ApplicationController
  # GET /team_registrations
  # GET /team_registrations.xml
  def index
    @team_registrations = TeamRegistration.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @team_registrations }
    end
  end

  # GET /team_registrations/1
  # GET /team_registrations/1.xml
  def show
    @team_registration = TeamRegistration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @team_registration }
    end
  end

  # GET /team_registrations/new
  # GET /team_registrations/new.xml
  def new
    @team_registration = TeamRegistration.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @team_registration }
    end
  end

  # GET /team_registrations/1/edit
  def edit
    @team_registration = TeamRegistration.find(params[:id])
  end

  # POST /team_registrations
  # POST /team_registrations.xml
  def create
    @team_registration = TeamRegistration.new(params[:team_registration])

    respond_to do |format|
      if @team_registration.save
        format.html { redirect_to(@team_registration, :notice => 'Team registration was successfully created.') }
        format.xml  { render :xml => @team_registration, :status => :created, :location => @team_registration }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @team_registration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /team_registrations/1
  # PUT /team_registrations/1.xml
  def update
    @team_registration = TeamRegistration.find(params[:id])

    respond_to do |format|
      if @team_registration.update_attributes(params[:team_registration])
        format.html { redirect_to(@team_registration, :notice => 'Team registration was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @team_registration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /team_registrations/1
  # DELETE /team_registrations/1.xml
  def destroy
    @team_registration = TeamRegistration.find(params[:id])
    @team_registration.destroy

    respond_to do |format|
      format.html { redirect_to(team_registrations_url) }
      format.xml  { head :ok }
    end
  end
end
