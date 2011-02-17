class TeamRegistration < ActiveRecord::Base
  belongs_to :team
  validates_presence_of :team
  belongs_to :competition
  validates_presence_of :competition
  belongs_to :category
  validates_presence_of :category
  
  #validates :category_rules
  
  def category_rules
    if EventSetting.get_b('competitor_birthdate_y_show',competition.event)
      if team.competitors.map{|c| c.age}.min < category.min_age
        errors.add I18n.t('activerecord.errors.models.team_registration.too_young', :cat => category.name)
      end
      if team.competitors.map{|c| c.age}.max > category.max_age
       errors.add I18n.t('activerecord.errors.models.team_registration.too_old', :cat => category.name)
      end
    end
    if team.competitors.count > category.max_team_size
      errors.add I18n.t('activerecord.errors.models.team_registration.too_many_members', :n => category.max_team_size, :cat => category.name)
    end
    # TODO: Add an event setting to disallow incomplete teams, then validate min_team_size
    # TODO: Check sex constraints
  end
  
  
end
