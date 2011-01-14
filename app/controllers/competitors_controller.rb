class CompetitorsController < ApplicationController
  # GET /competitors
  # GET /competitors.xml
  def index
    @competitors = Competitor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @competitors }
    end
  end

  # GET /competitors/1
  # GET /competitors/1.xml
  def show
    @competitor = Competitor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @competitor }
    end
  end

  # GET /competitors/new
  # GET /competitors/new.xml
  def new
    @competitor = Competitor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @competitor }
    end
  end

  # GET /competitors/1/edit
  def edit
    @competitor = Competitor.find(params[:id])
  end

  # POST /competitors
  # POST /competitors.xml
  def create
    @competitor = Competitor.new(params[:competitor])

    respond_to do |format|
      if @competitor.save
        format.html { redirect_to(@competitor, :notice => 'Competitor was successfully created.') }
        format.xml  { render :xml => @competitor, :status => :created, :location => @competitor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @competitor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /competitors/1
  # PUT /competitors/1.xml
  def update
    @competitor = Competitor.find(params[:id])

    respond_to do |format|
      if @competitor.update_attributes(params[:competitor])
        format.html { redirect_to(@competitor, :notice => 'Competitor was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @competitor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /competitors/1
  # DELETE /competitors/1.xml
  def destroy
    @competitor = Competitor.find(params[:id])
    @competitor.destroy

    respond_to do |format|
      format.html { redirect_to(competitors_url) }
      format.xml  { head :ok }
    end
  end
end
