class AgeRangesController < ApplicationController
  # GET /age_ranges
  # GET /age_ranges.xml
  def index
    @age_ranges = AgeRange.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @age_ranges }
    end
  end

  # GET /age_ranges/1
  # GET /age_ranges/1.xml
  def show
    @age_range = AgeRange.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @age_range }
    end
  end

  # GET /age_ranges/new
  # GET /age_ranges/new.xml
  def new
    @age_range = AgeRange.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @age_range }
    end
  end

  # GET /age_ranges/1/edit
  def edit
    @age_range = AgeRange.find(params[:id])
  end

  # POST /age_ranges
  # POST /age_ranges.xml
  def create
    @age_range = AgeRange.new(params[:age_range])

    respond_to do |format|
      if @age_range.save
        format.html { redirect_to(@age_range, :notice => 'Age range was successfully created.') }
        format.xml  { render :xml => @age_range, :status => :created, :location => @age_range }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @age_range.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /age_ranges/1
  # PUT /age_ranges/1.xml
  def update
    @age_range = AgeRange.find(params[:id])

    respond_to do |format|
      if @age_range.update_attributes(params[:age_range])
        format.html { redirect_to(@age_range, :notice => 'Age range was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @age_range.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /age_ranges/1
  # DELETE /age_ranges/1.xml
  def destroy
    @age_range = AgeRange.find(params[:id])
    @age_range.destroy

    respond_to do |format|
      format.html { redirect_to(age_ranges_url) }
      format.xml  { head :ok }
    end
  end
end
