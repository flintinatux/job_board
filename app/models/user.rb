# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  has_secure_password
  before_save { self.email.downcase! }
  before_create :create_remember_token

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  presence: true
  validates :email, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, if: -> (u){ u.password.present? }

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
