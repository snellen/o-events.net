class StartFeesController < ApplicationController
  # GET /start_fees
  # GET /start_fees.xml
  def index
    @start_fees = StartFee.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @start_fees }
    end
  end

  # GET /start_fees/1
  # GET /start_fees/1.xml
  def show
    @start_fee = StartFee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @start_fee }
    end
  end

  # GET /start_fees/new
  # GET /start_fees/new.xml
  def new
    @start_fee = StartFee.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @start_fee }
    end
  end

  # GET /start_fees/1/edit
  def edit
    @start_fee = StartFee.find(params[:id])
  end

  # POST /start_fees
  # POST /start_fees.xml
  def create
    @start_fee = StartFee.new(params[:start_fee])

    respond_to do |format|
      if @start_fee.save
        format.html { redirect_to(@start_fee, :notice => 'Start fee was successfully created.') }
        format.xml  { render :xml => @start_fee, :status => :created, :location => @start_fee }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @start_fee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /start_fees/1
  # PUT /start_fees/1.xml
  def update
    @start_fee = StartFee.find(params[:id])

    respond_to do |format|
      if @start_fee.update_attributes(params[:start_fee])
        format.html { redirect_to(@start_fee, :notice => 'Start fee was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @start_fee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /start_fees/1
  # DELETE /start_fees/1.xml
  def destroy
    @start_fee = StartFee.find(params[:id])
    @start_fee.destroy

    respond_to do |format|
      format.html { redirect_to(start_fees_url) }
      format.xml  { head :ok }
    end
  end
end
