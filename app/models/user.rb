require 'digest/sha2'

class User < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_confirmation_of :password
  
  attr_accessor :password_confirmation
  attr_reader :password
  
  validate :password_must_be_present
  
  
  class << self
    def authenticate(name, password)
      if user = find_by_name(name)
        if user.hashed_password == encrypt_password(password, user.salt)
          user
        end
      end
    end
    
    def encrypt_password(password, salt)
      Digest::SHA2.hexdigest(password + "sbunt" + salt)
    end
  end
  
  def password=(password)
    @password = password
    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end
  
  
  private
  
  def password_must_be_present
    errors.add(:password, "Missing Password") unless hashed_password.present?
  end
  
  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
end
