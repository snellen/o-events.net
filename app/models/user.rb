require 'digest/sha2'

class User < ActiveRecord::Base
  has_many :club_members
  has_many :clubs, :through => :club_members
  has_many :competitors
  has_many :events, :through => :competitors
  belongs_to :country
  belongs_to :nation
  
  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :confirmation => true

  attr_accessor :password_confirmation
  attr_reader :password

  validate :password_must_be_present

  # 'password' is a virtual attribute
  def password=(password)
    @password = password
    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end

  def User.authenticate(name, password)
    if user = find_by_username(name)
      if user.hashed_password == encrypt_password(password, user.salt)
        user
      end
    end
  end

  private

    def password_must_be_present
      errors.add(:password, "Missing password" ) unless hashed_password.present?
    end

    def generate_salt
      self.salt = self.object_id.to_s + rand.to_s
    end

    def User.encrypt_password(password, salt)
      Digest::SHA2.hexdigest(password + "wibble" + salt)
    end

end
