class TeamMembersController < ApplicationController
  # GET /team_members
  # GET /team_members.xml
  def index
    @team_members = TeamMember.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @team_members }
    end
  end

  # GET /team_members/1
  # GET /team_members/1.xml
  def show
    @team_member = TeamMember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @team_member }
    end
  end

  # GET /team_members/new
  # GET /team_members/new.xml
  def new
    @team_member = TeamMember.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @team_member }
    end
  end

  # GET /team_members/1/edit
  def edit
    @team_member = TeamMember.find(params[:id])
  end

  # POST /team_members
  # POST /team_members.xml
  def create
    @team_member = TeamMember.new(params[:team_member])

    respond_to do |format|
      if @team_member.save
        format.html { redirect_to(@team_member, :notice => 'Team member was successfully created.') }
        format.xml  { render :xml => @team_member, :status => :created, :location => @team_member }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @team_member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /team_members/1
  # PUT /team_members/1.xml
  def update
    @team_member = TeamMember.find(params[:id])

    respond_to do |format|
      if @team_member.update_attributes(params[:team_member])
        format.html { redirect_to(@team_member, :notice => 'Team member was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @team_member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /team_members/1
  # DELETE /team_members/1.xml
  def destroy
    @team_member = TeamMember.find(params[:id])
    @team_member.destroy

    respond_to do |format|
      format.html { redirect_to(team_members_url) }
      format.xml  { head :ok }
    end
  end
end
