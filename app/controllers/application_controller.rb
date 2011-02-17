class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_i18n_locale_from_params
  before_filter :authorize
  before_filter :dev_mode
  before_filter :redirect_to_ssl
  

  
  protected
  
  #i18n: if the first parameter is a locale, set the locale accordingly
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = " #{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end
  def default_url_options
    { :locale => I18n.locale }
  end


  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_path, :notice =>   noticeInfo(t('.pleaselogin'))
    end
  end
  
  def dev_mode
    if ENABLE_DEV_MODE_AUTH
      authenticate_or_request_with_http_basic do |username,password|
        username == 'dev' && password == DEV_MODE_PASSWORD && DEV_MODE_PASSWORD.length > 6
    end
    end
  end
  
  def redirect_to_ssl
    unless User.find_by_id(session[:user_id])
     redirect_to :protocol => "https://" unless (request.ssl? or request.local?)
    end
  end
  
  def noticeInfo(message)
    noticeTag(message, "notice")
  end
  
  def noticeError(message)
    noticeTag(message, "notice_error")
  end
  
  private
  def noticeTag(message, divId)
    ("<p id="+divId+">"+message.html_safe+"</p>").html_safe
  end
  
end
