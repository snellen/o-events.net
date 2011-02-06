class BillsController < ApplicationController
  
  # GET /bills/unpaid_fees
  def unpaid_fees
    @user = User.get_logged_in session
    unpaid_teams = @user.teams.where('bill_id IS NULL')

    @teams_by_event = Hash.new{|h, k| h[k] = []}
    for team in unpaid_teams do
      @teams_by_event[team.team_pool.event] << team
    end
    
    respond_to do |format|
      format.html # unpaid_fees.html.erb
    end
  end
  
  
  # GET /bills
  # GET /bills.xml
  def index
    @bills = Bill.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bills }
    end
  end

  # GET /bills/1
  # GET /bills/1.xml
  def show
    @bill = Bill.find(params[:id])
    check_auth @bill    
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bill }
    end
  end

  # GET /bills/new
  # GET /bills/new.xml
  def new
    @bill = Bill.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bill }
    end
  end

  # GET /bills/1/edit
  def edit
    @bill = Bill.find(params[:id])
    check_auth @bill
  end

  # POST /bills
  # POST /bills.xml
  def create
    @bill = Bill.new(params[:bill])

    respond_to do |format|
      if @bill.save
        format.html { redirect_to(@bill, :notice => 'Payment group was successfully created.') }
        format.xml  { render :xml => @bill, :status => :created, :location => @bill }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bills/1
  # PUT /bills/1.xml
  def update
    @bill = Bill.find(params[:id])
    check_auth @bill
    
    respond_to do |format|
      if @bill.update_attributes(params[:bill])
        format.html { redirect_to(@bill, :notice => 'Payment group was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.xml
  def destroy
    @bill = Bill.find(params[:id])
    check_auth @bill
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to(bills_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  #Check if current user has the right to access the bill
  def check_auth(bill)
    #TODO
  end
end
