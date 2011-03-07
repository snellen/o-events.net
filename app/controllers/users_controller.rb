class UsersController < ApplicationController
  skip_before_filter :authorize, :only => [:new,:create]
=begin
  # GET /users
  # GET /users.xml
  def index
    @users = User.order(:username)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
=end

  # GET /users/:id/change_password
  def change_password
    @user = User.find(params[:id])
  end
    
  # GET /users/1
  # GET /users/1.xml
  # GET /myaccount
  def show
    if params[:id]
      checkid session[:user_id], params[:id]
      @user = User.find(params[:id])
    else
      @user = User.get_logged_in(session)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    checkid session[:user_id], params[:id]
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user.id), :notice => noticeInfo(t('.usercreatesuccess')) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    checkid session[:user_id], params[:id]
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to user_url, :id => @user.id, :notice => noticeInfo(t('.userupdatesuccess')) }
        format.xml  { head :ok }
      else
        action = (params[:user].include?(:old_password) and params[:user].include?(:password) and params[:user].include?(:password_confirmation)) ? "change_password" : "edit" 
        format.html { render :action => action }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
=begin
  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    checkid session[:user_id], params[:id]
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.xml  { head :ok }
    end
  end
=end
  
  protected
  # Check if sessionId matches paramId
  def checkid(sessionId,paramId)
    unless sessionId == Integer(paramId)
      raise "Permission denied" 
    end    
  end
end
