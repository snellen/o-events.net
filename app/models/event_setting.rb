class EventSetting < ActiveRecord::Base
  
  validates :name, :presence => true, :uniqueness => true
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
  
  # Get array of hashes with custom fields for competitors/teams: each has a "field", "name", and a "required?" field 
  def self.custom_fields(model,event)
    custom_fields = ['text1','text2','text3','num1','num2','num3','flag1','flag2','flag3']
    ret = {}
    custom_fields.each do |f|
      if self.get_b(model+'_'+f+'_show',event)
        ret[f.to_sym] = { :name => self.get_s(model+'_'+f+'_name',event), :required? => self.get_b(model+'_'+f+'_require',event) }
      end
    end
    ret
  end
  
  # Get array of hashes with all optional fields to be shown in the specified event
  def self.competitor_fields(event)
    ret = self.custom_fields('competitor',event)
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

    ret    
  end
  
  def self.team_fields(event)
    self.custom_fields('team',event)
  end
end
