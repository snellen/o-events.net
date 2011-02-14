class AdditionalFeesController < ApplicationController
  # GET /additional_fees
  # GET /additional_fees.xml
  def index
    @additional_fees = AdditionalFee.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @additional_fees }
    end
  end

  # GET /additional_fees/1
  # GET /additional_fees/1.xml
  def show
    @additional_fee = AdditionalFee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @additional_fee }
    end
  end

  # GET /additional_fees/new
  # GET /additional_fees/new.xml
  def new
    @additional_fee = AdditionalFee.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @additional_fee }
    end
  end

  # GET /additional_fees/1/edit
  def edit
    @additional_fee = AdditionalFee.find(params[:id])
  end

  # POST /additional_fees
  # POST /additional_fees.xml
  def create
    @additional_fee = AdditionalFee.new(params[:additional_fee])

    respond_to do |format|
      if @additional_fee.save
        format.html { redirect_to(@additional_fee, :notice => 'Additional fee was successfully created.') }
        format.xml  { render :xml => @additional_fee, :status => :created, :location => @additional_fee }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @additional_fee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /additional_fees/1
  # PUT /additional_fees/1.xml
  def update
    @additional_fee = AdditionalFee.find(params[:id])

    respond_to do |format|
      if @additional_fee.update_attributes(params[:additional_fee])
        format.html { redirect_to(@additional_fee, :notice => 'Additional fee was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @additional_fee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /additional_fees/1
  # DELETE /additional_fees/1.xml
  def destroy
    @additional_fee = AdditionalFee.find(params[:id])
    @additional_fee.destroy

    respond_to do |format|
      format.html { redirect_to(additional_fees_url) }
      format.xml  { head :ok }
    end
  end

end
