require 'digest/sha2'

class User < ActiveRecord::Base
  has_many :club_members
  has_many :clubs, :through => :club_members
  has_many :competitors
  has_many :teams
  has_many :bills
  
  belongs_to :country
  validates_presence_of :country, :message => I18n.t('activerecord.errors.messages.mustbeselected'), :unless => "country_id.blank?"
  belongs_to :nation, :class_name => "Country"
  validates_presence_of :nation, :message => I18n.t('activerecord.errors.messages.mustbeselected')
  
  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true
  validates_format_of :email, :with => /(\S+)@(\S+)/
  validates :password, :confirmation => true
  validates_length_of :password, :minimum => 4
  validates :sex, :presence => true, :inclusion => {:in =>  %w( M F ), :message => I18n.t('activerecord.errors.messages.invalid'), :allow_nil => true}
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :birthdate_y, :presence => true, :numericality => {:only_integer => true, :allow_nil => true}, :inclusion => {:in => 1900..Date.today.year, :message => I18n.t('activerecord.errors.messages.between', :from => 1900, :to => Date.today.year.to_s), :allow_nil => true}
  validates :sicard_number, :numericality => {:only_integer => true, :allow_nil => true}, :inclusion => {:in => 1..16777216, :message => I18n.t('activerecord.errors.messages.between', :from => 1, :to => 16777216), :allow_nil => true}

  attr_accessor :password_confirmation
  attr_accessor :old_password
  attr_reader :password

  validate :password_must_be_present
  validate :check_old_password
  validate :password_change_only_if_old_password_provided

  # 'password' is a virtual attribute
  def password=(password)
    @password = password
    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
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

  def has_full_address
    (first_name and !first_name.empty?) and 
    (last_name and !last_name.empty?) and
    (address_line_1 and !address_line_1.empty?) and 
    (city and !city.empty?) and 
    (zipcode and !zipcode.empty?) and 
    country
  end
  
  def User.authenticate(identifier, password)
    user = nil
    if not user = find_by_username(identifier)
      user = find_by_email(identifier)
    end
    if user and user.hashed_password == encrypt_password(password, user.salt)
      user
    else
      nil
    end
  end

  def User.get_logged_in session
    if session[:user_id]
      User.find_by_id(session[:user_id])
    end
  end
  
  private

    def password_must_be_present
      errors.add(:password, I18n.t('activerecord.errors.messages.blank') ) unless hashed_password.present?
    end
    
    def password_change_only_if_old_password_provided
      if !new_record? and hashed_password.present? and !old_password
        errors.add(:old_password, I18n.t('activerecord.errors.messages.blank') )
      end
    end
    
    def check_old_password
      if old_password and !User.authenticate(username, old_password)
        errors.add(:old_password, I18n.t('activerecord.errors.messages.invalid') )
      end
    end

    def generate_salt
      self.salt = self.object_id.to_s + rand.to_s
    end

    def User.encrypt_password(password, salt)
      Digest::SHA2.hexdigest(password + "wibble" + salt)
    end

end
