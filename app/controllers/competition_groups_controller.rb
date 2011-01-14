class CompetitionGroupsController < ApplicationController
  # GET /competition_groups
  # GET /competition_groups.xml
  def index
    @competition_groups = CompetitionGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @competition_groups }
    end
  end

  # GET /competition_groups/1
  # GET /competition_groups/1.xml
  def show
    @competition_group = CompetitionGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @competition_group }
    end
  end

  # GET /competition_groups/new
  # GET /competition_groups/new.xml
  def new
    @competition_group = CompetitionGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @competition_group }
    end
  end

  # GET /competition_groups/1/edit
  def edit
    @competition_group = CompetitionGroup.find(params[:id])
  end

  # POST /competition_groups
  # POST /competition_groups.xml
  def create
    @competition_group = CompetitionGroup.new(params[:competition_group])

    respond_to do |format|
      if @competition_group.save
        format.html { redirect_to(@competition_group, :notice => 'Competition group was successfully created.') }
        format.xml  { render :xml => @competition_group, :status => :created, :location => @competition_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @competition_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /competition_groups/1
  # PUT /competition_groups/1.xml
  def update
    @competition_group = CompetitionGroup.find(params[:id])

    respond_to do |format|
      if @competition_group.update_attributes(params[:competition_group])
        format.html { redirect_to(@competition_group, :notice => 'Competition group was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @competition_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /competition_groups/1
  # DELETE /competition_groups/1.xml
  def destroy
    @competition_group = CompetitionGroup.find(params[:id])
    @competition_group.destroy

    respond_to do |format|
      format.html { redirect_to(competition_groups_url) }
      format.xml  { head :ok }
    end
  end
end
