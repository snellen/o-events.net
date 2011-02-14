class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_i18n_locale_from_params
  before_filter :authorize
  before_filter :dev_mode

  
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
      redirect_to login_path, :notice =>   t('.pleaselogin')
    end
  end
  
  def dev_mode
    authenticate_or_request_with_http_basic do |username,password|
      username == 'dev' && password == DEV_MODE_PASSWORD && DEV_MODE_PASSWORD.length > 6
    end
  end
  
end
