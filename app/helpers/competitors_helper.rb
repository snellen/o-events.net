module CompetitorsHelper
  
  def required_label(field, required = true)
    if required
      label(:competitor, field, (I18n.t('activerecord.attributes.competitor.'+field.to_s)+' <span class="required_field">*</span>').html_safe)
    else
      label(:competitor, field, I18n.t('activerecord.attributes.competitor.'+field.to_s))      
    end
  end
  
end
