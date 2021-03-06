# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :responses
  has_many :contributions

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  NO_SPACES_REGEX = /^[\S]+$/
  validates :name, presence: true, length: { maximum: 50 }, format: { with: NO_SPACES_REGEX, message: "can't contain spaces" }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  									uniqueness: { case_sensitive: false }
  
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  after_validation { self.errors.messages.delete(:password_digest) }

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end