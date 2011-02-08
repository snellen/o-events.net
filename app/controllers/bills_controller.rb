class BillsController < ApplicationController
  
  # GET /bills/unpaid_fees
  def unpaid_fees
    @user = User.get_logged_in session
    unpaid_teams = @user.teams.where('bill_id IS NULL', :paid_by_club => false)

    @teams_by_event = Hash.new{|h, k| h[k] = []}
    for team in unpaid_teams do
      if team.start_fee > 0
        @teams_by_event[team.team_pool.event] << team
      end
    end
    
    respond_to do |format|
      format.html # unpaid_fees.html.erb
    end
  end
  
  
  # GET /bills
  # GET /bills.xml
  def index
    @user = User.get_logged_in session
    allBills = @user.bills
    @bills = allBills.where(:id => Team.where(:bill_id => allBills.map{|b| b.id}, :paid_by_club => false).map {|t| t.bill_id}).order('created_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bills }
    end
  end

  # GET /bills/1
  # GET /bills/1.xml
  def show
    @user = User.get_logged_in session
    @bill = @user.bills.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bill }
    end
  end

  # GET /bills/new
  # GET /bills/new.xml
  def new
    raise "Missing parameter" unless params[:event]
    @user = User.get_logged_in session
    @event = Event.find(params[:event])
    @teams = @user.teams.where(:team_pool_id => TeamPool.where(:event_id => @event.id).map{|tp| tp.id}, :bill_id => nil, :paid_by_club => false)
    @teams_hash = generate_teams_hash(@teams)
    @total_amount = @teams.inject(0) { |sum, t| sum + t.start_fee }
    @bill = Bill.new
    @userAddressKnown = false
    if @user.has_full_address
      @userAddressKnown = true
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bill }
    end
  end

  # POST /bills
  # POST /bills.xml
  def create
    
    #check user
    @user = User.get_logged_in session
    raise "Full address is required to create bills" unless @user.has_full_address
    
    #check teams
    teamIds = params[:bill][:team_ids]
    teamIdsHash = params[:bill][:team_ids_hash]
    raise "Missing teams for bill" unless teamIds != nil and !teamIds.empty?
    teams = Team.where(:id => teamIds)
    raise "Invalid team ids" unless !teams.empty? and teamIds.size == teams.size and teamIdsHash and check_team_hash(teams, teamIdsHash)
    eventId = teams[0].team_pool.event.id
    teams.map do |t|
      raise "Invalid collection of teams" if t.user_id != @user.id or t.bill_id != nil or t.team_pool.event.id != eventId
    end
    
    @bill = Bill.new
    @bill.exchange_rate = 1.0 #TODO
    @bill.is_paper_bill = false
    @bill.is_paper_bill_sent = false
    @bill.is_paid = false
    @bill.reference_number = generate_reference_number(@user)
    
    @bill.user = @user
    @bill.first_name = @user.first_name
    @bill.last_name = @user.last_name
    @bill.address_line_1 = @user.address_line_1
    @bill.address_line_2 = @user.address_line_2
    @bill.city = @user.city
    @bill.zipcode = @user.zipcode
    @bill.province = @user.province
    @bill.country = @user.country
    
    error = false
    if @bill.save
      teams.map do |t| 
        t.bill = @bill
        t.save
      end
    else
      error = true
    end
    
    respond_to do |format|
      if !error
        format.html { redirect_to(@bill, :notice => 'Bill was successfully created.') }
        format.xml  { render :xml => @bill, :status => :created, :location => @bill }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  private
  #Check if current user has the right to access the bill
  def check_auth(user, bill)
    raise "Permission denied" unless bill.user_id == user.id
  end
  
  def generate_reference_number(user)
    randString = ""
    19.times{randString  << (48 + rand(10)).chr}
    ("%07d" % user.id)[-7..-1]+randString
  end
   
  def secretString
    IO.read("config/.billsecret")
    rescue Exception 
      "hGh%d_mrbyd-U2C#+;m}0yb4`Utl3F"
  end
  
  def generate_teams_hash(teams)
    concatString = secretString
    teams.each do |t|
      concatString += "#"+t.created_at.to_s()+t.id.to_s()
    end
    Digest::SHA2.hexdigest(concatString)
  end
    
  def check_team_hash(teams, hash)
    h = generate_teams_hash(teams)
    h == hash
  end
  
end
