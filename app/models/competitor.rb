class Competitor < ActiveRecord::Base
  has_many :chips
  has_many :start_blocks
  has_many :start_times
  belongs_to :country
  validates_presence_of :country, :unless => "country_id.blank?"
  belongs_to :competing_club
  validates_presence_of :competing_club, :unless => "competing_club_id.blank?"
  belongs_to :nation, :class_name => "Country"
  validates_presence_of :nation, :unless => "nation_id.blank?"
  belongs_to :user
  validates_presence_of :user, :unless => "user_id.blank?"
  belongs_to :team
  validates_presence_of :team, :unless => "team_id.blank?"
  belongs_to :event
  validates_presence_of :event
  has_one :leader_team, :foreign_key => "leader_id"
  validates_format_of :email, :with => /(\S+)@(\S+)/, :allow_nil => true
  validates :sex, :inclusion => {:in =>  %w( M F ), :allow_nil => true}
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :birthdate_y, :numericality => {:only_integer => true, :allow_nil => true}, :inclusion => {:in => 1900..Date.today.year, :allow_nil => true}
  validates :sortkey, :presence => true
  validates_inclusion_of :flag1, :in => [true, false], :unless => "flag1.blank?"
  validates_inclusion_of :flag2, :in => [true, false], :unless => "flag2.blank?"
  validates_inclusion_of :flag3, :in => [true, false], :unless => "flag3.blank?"
  validates_numericality_of :num1, :only_integer => true, :unless => "num1.blank?"
  validates_numericality_of :num2, :only_integer => true, :unless => "num2.blank?"
  validates_numericality_of :num3, :only_integer => true, :unless => "num3.blank?"

  
  # Optional fields which can be shown without being required
  validates_each :license_number, :email, :phone, :city do |record, attr, value|
    if !record.event.nil?
      record.errors.add attr, I18n.t('activerecord.errors.messages.blank') if value.blank? and EventSetting.get_b('competitor_'+attr.to_s+'_require',record.event)
    end
  end
  
  # Custom fields which can be shown without being required
  validates_each :text1, :text2, :text3, :num1, :num2, :num3 do |record, attr, value|
    if !record.event.nil?
      record.errors.add EventSetting.get_s('competitor_'+attr.to_s+'_name',record.event), I18n.t('activerecord.errors.messages.blank') if value.blank? and EventSetting.get_b('competitor_'+attr.to_s+'_require',record.event)
    end
  end  
  
  # Range check of numerical fields
  validates_each :num1, :num2, :num3 do |record, attr, value|
    if !record.event.nil?
      if maxStr = EventSetting.get_s('competitor_'+attr.to_s+'_max',record.event) and !value.blank?
        max = maxStr.to_i
        record.errors.add EventSetting.get_s('competitor_'+attr.to_s+'_name',record.event), I18n.t('activerecord.errors.messages.lessthan', :max => max) if value > max
      end
      if minStr = EventSetting.get_s('competitor_'+attr.to_s+'_min',record.event) and !value.blank?
        min = minStr.to_i
        record.errors.add EventSetting.get_s('competitor_'+attr.to_s+'_name',record.event), I18n.t('activerecord.errors.messages.greaterthan', :min => min) if value < min
      end
    end
  end  

  # Optional fields which are required when shown 
  validates_each :nation, :birthdate_y, :competing_club do |record, attr, value|
    if !record.event.nil?
      record.errors.add attr, I18n.t('activerecord.errors.messages.blank') if value.blank? and EventSetting.get_b('competitor_'+attr.to_s+'_show',record.event)
    end
  end  

  # Custom fields which are required when shown 
  validates_each :flag1, :flag2, :flag3 do |record, attr, value|
    if !record.event.nil?
      record.errors.add EventSetting.get_s('competitor_'+attr.to_s+'_name',record.event), I18n.t('activerecord.errors.messages.blank') if value.blank? and EventSetting.get_b('competitor_'+attr.to_s+'_show',record.event)
    end
  end  
  
  validate :presence_of_address
  
  
  def presence_of_address
    if !event.nil?
      if (address_line_1.blank? and address_line_2.blank?) or (country_id.blank?) or (zipcode.blank?) #city is validated above
        errors.add 'Address must be present' if EventSetting.get_b('competitor_address_require',event) #TODO I18n
      end
    end
  end 

  
  
  # Provides a reader for the full name
  # Pass true to it to get an alphabetically sortable name
  def full_name(alpha = false)
    if alpha then
      last_name+', '+first_name
    else
      first_name+' '+last_name
    end
  end
  
  # Calculates the age
  # TODO: This may need to use the exact date of birth, depending on event settings
  def age
    Time.now.year - birthdate_y
  end
  
  
  # Builds a Competitor and CompetingClub for the specified User and Club. (The TeamPool is needed to find existing CompetingClubs.)
  # The CompetingClub is saved immediately to avoid creating multiple CompetingClubs when saving multiple Competitors with the same club.
  def self.build_from_user(user,club,team_pool)
    attr = {:license_number => user.license_number, :region_code => user.region_code, :first_name => user.first_name, :last_name => user.last_name, :email => user.email, :phone => user.phone, :address_line_1 => user.address_line_1, :address_line_2 => user.address_line_2, :zipcode => user.zipcode, :city => user.city, :province => user.province, :sex => user.sex, :birthdate_y => user.birthdate_y, :birthdate_m => user.birthdate_m, :birthdate_d => user.birthdate_d, :country_id => user.country_id, :nation_id => user.nation_id, :user_id => user.id}
    c = self.new(attr)
    if !club.nil? # A competitor can be built, but not saved, without a competing club.
      c.competing_club = CompetingClub.create_from_club(club,team_pool)
    end
    c
  end
    
end
