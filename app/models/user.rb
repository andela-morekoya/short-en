class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  before_save { email.downcase! }
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }

  has_secure_password

  has_many :links
  has_many :visits

  def self.get_user(email)
    User.where(email: email).first
  end
end
