class Team < ActiveRecord::Base
  belongs_to :bill
  validates_presence_of :bill, :unless => "bill_id.blank?"
  attr_protected :bill_id
  belongs_to :competing_club
  validates_presence_of :competing_club, :unless => "competing_club_id.blank?" 
  belongs_to :team_pool
  validates_presence_of :team_pool
  belongs_to :nation, :class_name => "Country"
  validates_presence_of :nation, :unless => "nation_id.blank?"
  belongs_to :user
  validates_presence_of :user, :unless => "user_id.blank?"
  belongs_to :leader, :class_name => "Competitor"
  validates_presence_of :leader, :unless => "leader_id.blank?"
  
  has_many :competitors
  has_many :team_registrations
  has_many :total_results

  validates_presence_of :registration_time
  validates_inclusion_of :paid_by_club, :in => [true, false]
  validates_numericality_of :start_fee, :greater_than_or_equal_to => 0.0
  validates_inclusion_of :flag1, :in => [true, false], :unless => "flag1.blank?"
  validates_inclusion_of :flag2, :in => [true, false], :unless => "flag2.blank?"
  validates_inclusion_of :flag3, :in => [true, false], :unless => "flag3.blank?"
  validates_numericality_of :num1, :only_integer => true, :unless => "num1.blank?"
  validates_numericality_of :num2, :only_integer => true, :unless => "num2.blank?"
  validates_numericality_of :num3, :only_integer => true, :unless => "num3.blank?"
  
  # Optional fields which can be shown without being required
  validates_each :text1, :text2, :text3, :num1, :num2, :num3 do |record, attr, value|
    if !record.team_pool.nil?
      record.errors.add attr, I18n.t('activerecord.errors.messages.blank') if value.nil? and EventSetting.get_b('team_'+attr.to_s+'_require',record.team_pool.event)
    end
  end

  # Optional fields which are required when shown 
  validates_each :nation, :name, :competing_club, :flag1, :flag2, :flag3 do |record, attr, value|
    if !record.team_pool.nil?
      record.errors.add attr, I18n.t('activerecord.errors.messages.blank') if value.nil? and EventSetting.get_b('team_'+attr.to_s+'_show',record.team_pool.event)
    end
  end    
  
  
  # TODO the following two functions may be obsolete.  
  
  # Adds a competitor to the team.
  # Defines the team leader if the team was empty, and sets a sortkey for the new competitor.
  def add_member(competitor)
    if @competitors.empty?
      @leader = competitor
      competitor.sortkey = 1
    else
      competitor.sortkey = @competitors.maximum(:sortkey)+1
    end
    @competitors << competitor
  end
  
  # Removes a competitor from the team and destroys it.
  def remove_member(competitor)
    competitor.destroy
    self.reload
    if @leader_id == competitor.id
      if @competitors.count == 1
        @leader = nil
      else
        @leader = @competitors.first
      end
    end
  end
    
  def is_single
    category.max_team_size == 1
  end
  
  # Returns team name if available, list of members otherwise. Always returns runner name in categories without teams. 
  def get_display_name
    if EventSetting.get_b('team_name_show',team_pool.event)
      is_single ? competitors.first.full_name : name
    else
      member_names
    end
  end
  
  def category_list
    Category.where(:id => team_registrations.map{|reg| reg.id}).map{|cat| cat.name}.to_sentence
  end
  
  def member_names
    competitors.map{|c| c.full_name}.to_sentence
  end
end
