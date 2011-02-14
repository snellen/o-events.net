class EventSetting < ActiveRecord::Base
  
  validates :name, :presence => true
  validates_uniqueness_of :name, :scope => :event_id
  validates_presence_of :event_id  

  # Get a string setting (not set => nil)
  def self.get_s(name, event)
    res = self.where(:name => name, :event_id => event.id)
    if res.empty?
      nil
    else
      res.first.value
    end
  end
  
  # Set a string setting
  def self.set_s(name, value, event)
    res = self.where(:name => name, :event_id => event.id)
    if res.empty?
      setting = self.new(:name => name, :value => value, :event_id => event.id)
    else
      setting = res.first
      setting.value = value
    end
    setting.save!    
  end
  
  # Get a Boolean setting (not set => false)
  def self.get_b(name,event)
    val = self.get_s(name, event)
    (val.to_i != 0)
  end
  
  #Set a Boolean setting
  def self.set_b(name, value, event)
    self.set_s(name, (value ? '1' : '0'), event)
  end
  
  # Get an integer setting (not set => 0)
  def self.get_i(name,event)
    self.get_s(name,event).to_i
  end
  
  # Set an integer setting
  def self.set_i(name,value,event)
    self.set_s(name,value.to_s,event)
  end
  
  # Get a hash that contains a subhash for each team- or competitor-specific custom field. Each hash has a "name", and a "required?" field 
  def self.custom_fields(model,event)
    custom_fields = ['text1','text2','text3','num1','num2','num3','flag1','flag2','flag3']
    ret = {}
    custom_fields.each do |f|
      if self.get_b(model+'_'+f+'_show',event)
        if f[0] == ?f
          req = true #flags are always required
        else
          req = self.get_b(model+'_'+f+'_require',event)
        end
        ret[f.to_sym] = { :name => self.get_s(model+'_'+f+'_name',event), :required? => req }
      end
    end
    ret
  end
  
  # Get a hash that contains a subhash for each optional competitor-specific field that is to be shown in the specified event (does not include custom fields)
  def self.competitor_fields(event)
    ret = {}
    comp_fields = ['nation','license_number','email','phone','address','city','birthdate_y','competing_club']
    comp_fields.each do |f|
      if self.get_b('competitor_'+f+'_show',event)
        if f == 'birthdate_y' or f == 'competing_club' or f == 'nation' #these three are always required if shown
          req = true          
        else
          req = self.get_b('competitor_'+f+'_require')
        end
        ret[f.to_sym] = { :name => I18n.t('activerecord.attributes.competitor.'+f), :required? => req }
      end
    end
    
    # Special check: Nation is mandatory if competing club is mandatory
    if ret[:competing_club] and !ret[:nation]
      ret[:nation] = {:name => I18n.t('activerecord.attributes.competitor.nation'), :required? => true}
    end
  
    # Special check: Address requires city
    if ret[:address]
      if !ret[:city]
        ret[:city] = {:name => I18n.t('activerecord.attributes.competitor.city'), :required? => ret[:address][:required?]}
      elsif !ret[:city][:required?]
        ret[:city][:required?] = ret[:address][:required?] #Make sure the city is required whenever the address is required
      end
    end
    
    ret    
  end
  
  # Get a hash that contains a a subhash for each optional team-specific field that is to be shown in the specified event (does not include custom fields)
  def self.team_fields(event)
    ret = {}
    team_fields = ['nation','name','competing_club'] #These are all required if shown
    team_fields.each do |f|
      if self.get_b('team_'+f+'_show',event)
        ret[f.to_sym] = {:name => I18n.t('activerecord.attributes.team.'+f), :required? => true}
      end
    end
    ret    
  end
  
end
