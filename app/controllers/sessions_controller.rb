class SessionsController < ApplicationController
  skip_before_filter :authorize
 
  def new
    if alreadyLoggedIn
      redirect_to events_index_url
    end
  end

  def create
    if alreadyLoggedIn
      redirect_to events_index_url
    end
    if user = User.authenticate(params[:identifier], params[:password])
      session[:user_id] = user.id
      redirect_to events_index_url
    else
      redirect_to login_url, :notice => noticeError(t('.loginfailed'))
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to events_index_url, :notice => noticeInfo("Logged out")
  end

  private
  def alreadyLoggedIn
    User.find_by_id(session[:user_id]) != nil
  end
end
