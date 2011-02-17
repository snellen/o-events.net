class CompetingClubsController < ApplicationController
  # GET /competing_clubs
  # GET /competing_clubs.xml
  def index
    @competing_clubs = CompetingClub.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @competing_clubs }
    end
  end

  # GET /competing_clubs/1
  # GET /competing_clubs/1.xml
  def show
    @competing_club = CompetingClub.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @competing_club }
    end
  end

  # GET /competing_clubs/new
  # GET /competing_clubs/new.xml
  def new
    @competing_club = CompetingClub.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @competing_club }
    end
  end

  # GET /competing_clubs/1/edit
  def edit
    @competing_club = CompetingClub.find(params[:id])
  end

  # POST /competing_clubs
  # POST /competing_clubs.xml
  def create
    @competing_club = CompetingClub.new(params[:competing_club])

    respond_to do |format|
      if @competing_club.save
        format.html { redirect_to(@competing_club, :notice => noticeInfo('Competing club was successfully created.')) }
        format.xml  { render :xml => @competing_club, :status => :created, :location => @competing_club }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @competing_club.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /competing_clubs/1
  # PUT /competing_clubs/1.xml
  def update
    @competing_club = CompetingClub.find(params[:id])

    respond_to do |format|
      if @competing_club.update_attributes(params[:competing_club])
        format.html { redirect_to(@competing_club, :notice => noticeInfo('Competing club was successfully updated.')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @competing_club.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /competing_clubs/1
  # DELETE /competing_clubs/1.xml
  def destroy
    @competing_club = CompetingClub.find(params[:id])
    @competing_club.destroy

    respond_to do |format|
      format.html { redirect_to(competing_clubs_url) }
      format.xml  { head :ok }
    end
  end 
end
