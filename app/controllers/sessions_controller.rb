class SessionsController < ApplicationController
  skip_before_filter :authorize
  before_filter :already_logged_in, :only => [:new, :create]
 
  def new
  end

  def create
    if user = User.authenticate(params[:identifier], params[:password])
      session[:user_id] = user.id
      redirect_to redirect_path
    else
      redirect_to login_url({:redirect_path => redirect_path}), :notice => noticeError(t('.loginfailed'))
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to events_index_url, :notice => noticeInfo("Logged out")
  end

  private
  def already_logged_in
    unless User.find_by_id(session[:user_id]) == nil
      redirect_to events_index_url
    end
  end
  
  def redirect_path
    params[:redirect_path] || events_index_url
  end
end
