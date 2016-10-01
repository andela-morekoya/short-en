class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, presence: true, 
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }
  has_secure_password

  has_many :links

end
