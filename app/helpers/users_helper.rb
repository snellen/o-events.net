module UsersHelper

  def user_required_label(field, required = true)
    if required
      label(:user, field, (I18n.t('activerecord.attributes.user.'+field.to_s)+' <span class="required_field">*</span>').html_safe)
    else
      label(:user, field, I18n.t('activerecord.attributes.user.'+field.to_s))      
    end
  end
  
end
