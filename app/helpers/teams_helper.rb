module TeamsHelper

  def required_label(field, required = true)
    if required
      label(:team, field, (I18n.t('activerecord.attributes.team.'+field.to_s)+' <span class="required_field">*</span>').html_safe)
    else
      label(:team, field, I18n.t('activerecord.attributes.team.'+field.to_s))      
    end
  end
  
end
