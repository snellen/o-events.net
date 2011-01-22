class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_i18n_locale_from_params
  
  protected
  
  #nav_tabs = ['Wettkampfkalender','Meine Wettkämpfe','Neuer Wettkampf','Meine Vereine','Mein Konto','Meine Rechnungen']
  #if session[:user_id]
  #  nav_urls = [events_path,events_path(:user_id => session[:user_id]),new_event_path,clubs_path(:user_id => session[:user_id]),user_path,payment_groups_path(:user_id => session[:user_id])]
  #else
  #  nav_urls = [events_path,login_path,new_event_path,login_path,login_path,login_path]
  #end
  
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

end
