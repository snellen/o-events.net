class TeamPoolsController < ApplicationController
  # GET /team_pools
  # GET /team_pools.xml
  def index
    @team_pools = TeamPool.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @team_pools }
    end
  end

  # GET /team_pools/1
  # GET /team_pools/1.xml
  def show
    @team_pool = TeamPool.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @team_pool }
    end
  end

  # GET /team_pools/new
  # GET /team_pools/new.xml
  def new
    @team_pool = TeamPool.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @team_pool }
    end
  end

  # GET /team_pools/1/edit
  def edit
    @team_pool = TeamPool.find(params[:id])
  end

  # POST /team_pools
  # POST /team_pools.xml
  def create
    @team_pool = TeamPool.new(params[:team_pool])

    respond_to do |format|
      if @team_pool.save
        format.html { redirect_to(@team_pool, :notice => noticeInfo('Team pool was successfully created.')) }
        format.xml  { render :xml => @team_pool, :status => :created, :location => @team_pool }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @team_pool.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /team_pools/1
  # PUT /team_pools/1.xml
  def update
    @team_pool = TeamPool.find(params[:id])

    respond_to do |format|
      if @team_pool.update_attributes(params[:team_pool])
        format.html { redirect_to(@team_pool, :notice => noticeInfo('Team pool was successfully updated.')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @team_pool.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /team_pools/1
  # DELETE /team_pools/1.xml
  def destroy
    @team_pool = TeamPool.find(params[:id])
    @team_pool.destroy

    respond_to do |format|
      format.html { redirect_to(team_pools_url) }
      format.xml  { head :ok }
    end
  end
end
