class ClubMembersController < ApplicationController
  # GET /club_members
  # GET /club_members.xml
  def index
    @club_members = ClubMember.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @club_members }
    end
  end

  # GET /club_members/1
  # GET /club_members/1.xml
  def show
    @club_member = ClubMember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @club_member }
    end
  end

  # GET /club_members/new
  # GET /club_members/new.xml
  def new
    @club_member = ClubMember.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @club_member }
    end
  end

  # GET /club_members/1/edit
  def edit
    @club_member = ClubMember.find(params[:id])
  end

  # POST /club_members
  # POST /club_members.xml
  def create
    @club_member = ClubMember.new(params[:club_member])

    respond_to do |format|
      if @club_member.save
        format.html { redirect_to(@club_member, :notice => 'Club member was successfully created.') }
        format.xml  { render :xml => @club_member, :status => :created, :location => @club_member }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @club_member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /club_members/1
  # PUT /club_members/1.xml
  def update
    @club_member = ClubMember.find(params[:id])

    respond_to do |format|
      if @club_member.update_attributes(params[:club_member])
        format.html { redirect_to(@club_member, :notice => 'Club member was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @club_member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /club_members/1
  # DELETE /club_members/1.xml
  def destroy
    @club_member = ClubMember.find(params[:id])
    @club_member.destroy

    respond_to do |format|
      format.html { redirect_to(club_members_url) }
      format.xml  { head :ok }
    end
  end 
end
