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
            from.strftime(t(dformat+'.single'))
          else
            from.strftime(t(dformat+'.day_from'))+to.strftime(t(dformat+'.day_to'))
          end
        else
          from.strftime(t(dformat+'.month_from'))+to.strftime(t(dformat+'.month_to'))
        end
      else
        from.strftime(t(dformat+'.year_from'))+to.strftime(t(dformat+'.year_to'))
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
  
end
