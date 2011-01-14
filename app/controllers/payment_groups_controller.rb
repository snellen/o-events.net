class PaymentGroupsController < ApplicationController
  # GET /payment_groups
  # GET /payment_groups.xml
  def index
    @payment_groups = PaymentGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @payment_groups }
    end
  end

  # GET /payment_groups/1
  # GET /payment_groups/1.xml
  def show
    @payment_group = PaymentGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @payment_group }
    end
  end

  # GET /payment_groups/new
  # GET /payment_groups/new.xml
  def new
    @payment_group = PaymentGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @payment_group }
    end
  end

  # GET /payment_groups/1/edit
  def edit
    @payment_group = PaymentGroup.find(params[:id])
  end

  # POST /payment_groups
  # POST /payment_groups.xml
  def create
    @payment_group = PaymentGroup.new(params[:payment_group])

    respond_to do |format|
      if @payment_group.save
        format.html { redirect_to(@payment_group, :notice => 'Payment group was successfully created.') }
        format.xml  { render :xml => @payment_group, :status => :created, :location => @payment_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @payment_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /payment_groups/1
  # PUT /payment_groups/1.xml
  def update
    @payment_group = PaymentGroup.find(params[:id])

    respond_to do |format|
      if @payment_group.update_attributes(params[:payment_group])
        format.html { redirect_to(@payment_group, :notice => 'Payment group was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @payment_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_groups/1
  # DELETE /payment_groups/1.xml
  def destroy
    @payment_group = PaymentGroup.find(params[:id])
    @payment_group.destroy

    respond_to do |format|
      format.html { redirect_to(payment_groups_url) }
      format.xml  { head :ok }
    end
  end
end
