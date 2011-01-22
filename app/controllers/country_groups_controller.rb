class CountryGroupsController < ApplicationController
  # GET /country_groups
  # GET /country_groups.xml
  def index
    @country_groups = CountryGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @country_groups }
    end
  end

  # GET /country_groups/1
  # GET /country_groups/1.xml
  def show
    @country_group = CountryGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @country_group }
    end
  end

  # GET /country_groups/new
  # GET /country_groups/new.xml
  def new
    @country_group = CountryGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @country_group }
    end
  end

  # GET /country_groups/1/edit
  def edit
    @country_group = CountryGroup.find(params[:id])
  end

  # POST /country_groups
  # POST /country_groups.xml
  def create
    @country_group = CountryGroup.new(params[:country_group])

    respond_to do |format|
      if @country_group.save
        format.html { redirect_to(@country_group, :notice => 'Country group was successfully created.') }
        format.xml  { render :xml => @country_group, :status => :created, :location => @country_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @country_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /country_groups/1
  # PUT /country_groups/1.xml
  def update
    @country_group = CountryGroup.find(params[:id])

    respond_to do |format|
      if @country_group.update_attributes(params[:country_group])
        format.html { redirect_to(@country_group, :notice => 'Country group was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @country_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /country_groups/1
  # DELETE /country_groups/1.xml
  def destroy
    @country_group = CountryGroup.find(params[:id])
    @country_group.destroy

    respond_to do |format|
      format.html { redirect_to(country_groups_url) }
      format.xml  { head :ok }
    end
  end
end
