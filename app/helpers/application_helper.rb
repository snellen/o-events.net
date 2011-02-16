module ApplicationHelper
    
  # Generates a human-readable representation of a date interval (e.g. "Feb 13-15, 2027")
  def date_interval(from, to, dformat='long')
    dformat = 'date.interval_'+dformat

    if to.nil? or from.nil?
      t(dformat+'.nil')
    else
      if to.year == from.year
        if to.month == from.month
          if to.day == from.day
            l(from, :format => t(dformat+'.single'))
          else
            l(from, :format => t(dformat+'.day_from')) + l(to, :format => t(dformat+'.day_to'))
          end
        else
          l(from, :format => t(dformat+'.month_from')) + l(to, :format => t(dformat+'.month_to'))
        end
      else
        l(from, :format => t(dformat+'.year_from')) + l(to, :format => t(dformat+'.year_to'))
      end
    end
  end

  # Provides an event setting. Assumes that @event is defined.
  def event_get(setting)
    @event.event_settings.where(:name => setting).first  
  end
  
  # Displays an icon from /public/layout/icons, with localized title text
  def icon(name)
    if FileTest.exist?("public/layout/icons/#{name}.png")
      image_tag "/layout/icons/#{name}.png", :alt => I18n.t('icons.'+name), :title => I18n.t('icons.'+name)
    else
      "[icon not found: #{name}]"      
    end
  end
  
  # Displays a GET form with a button that includes parameters as hidden fields
  # (The Rails button_to helper does not support parameters in GET forms)
  def get_button_to(caption, url, get_params = {})
    url = ERB::Util.h(url)
    caption = ERB::Util.h(caption)
    ret = '<form method="get" action="'+url+'"  class="button_to">'
    get_params.each do |par,val|
      ret += hidden_field_tag par, val
    end
    ret += '<div><input type="submit" value="'+caption+'" /></div></form>'
    ret.html_safe
  end
end
