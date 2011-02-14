class TotalResultsController < ApplicationController
  # GET /total_results
  # GET /total_results.xml
  def index
    @total_results = TotalResult.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @total_results }
    end
  end

  # GET /total_results/1
  # GET /total_results/1.xml
  def show
    @total_result = TotalResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @total_result }
    end
  end

  # GET /total_results/new
  # GET /total_results/new.xml
  def new
    @total_result = TotalResult.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @total_result }
    end
  end

  # GET /total_results/1/edit
  def edit
    @total_result = TotalResult.find(params[:id])
  end

  # POST /total_results
  # POST /total_results.xml
  def create
    @total_result = TotalResult.new(params[:total_result])

    respond_to do |format|
      if @total_result.save
        format.html { redirect_to(@total_result, :notice => 'Total result was successfully created.') }
        format.xml  { render :xml => @total_result, :status => :created, :location => @total_result }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @total_result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /total_results/1
  # PUT /total_results/1.xml
  def update
    @total_result = TotalResult.find(params[:id])

    respond_to do |format|
      if @total_result.update_attributes(params[:total_result])
        format.html { redirect_to(@total_result, :notice => 'Total result was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @total_result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /total_results/1
  # DELETE /total_results/1.xml
  def destroy
    @total_result = TotalResult.find(params[:id])
    @total_result.destroy

    respond_to do |format|
      format.html { redirect_to(total_results_url) }
      format.xml  { head :ok }
    end
  end 
end
