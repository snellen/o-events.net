class NationGroupsController < ApplicationController
  # GET /nation_groups
  # GET /nation_groups.xml
  def index
    @nation_groups = NationGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @nation_groups }
    end
  end

  # GET /nation_groups/1
  # GET /nation_groups/1.xml
  def show
    @nation_group = NationGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @nation_group }
    end
  end

  # GET /nation_groups/new
  # GET /nation_groups/new.xml
  def new
    @nation_group = NationGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @nation_group }
    end
  end

  # GET /nation_groups/1/edit
  def edit
    @nation_group = NationGroup.find(params[:id])
  end

  # POST /nation_groups
  # POST /nation_groups.xml
  def create
    @nation_group = NationGroup.new(params[:nation_group])

    respond_to do |format|
      if @nation_group.save
        format.html { redirect_to(@nation_group, :notice => 'Nation group was successfully created.') }
        format.xml  { render :xml => @nation_group, :status => :created, :location => @nation_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @nation_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /nation_groups/1
  # PUT /nation_groups/1.xml
  def update
    @nation_group = NationGroup.find(params[:id])

    respond_to do |format|
      if @nation_group.update_attributes(params[:nation_group])
        format.html { redirect_to(@nation_group, :notice => 'Nation group was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @nation_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /nation_groups/1
  # DELETE /nation_groups/1.xml
  def destroy
    @nation_group = NationGroup.find(params[:id])
    @nation_group.destroy

    respond_to do |format|
      format.html { redirect_to(nation_groups_url) }
      format.xml  { head :ok }
    end
  end
end
