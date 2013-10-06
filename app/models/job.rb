# == Schema Information
#
# Table name: jobs
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  category_id  :integer
#  location     :string(255)
#  description  :text
#  instructions :string(255)
#  expires_at   :datetime
#  highlight    :boolean
#  company      :string(255)
#  url          :string(255)
#  email        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Job < ActiveRecord::Base
  include Parameterized
  parameterize_by :title
  belongs_to :category
  after_initialize :set_defaults

  DURATION = 30.days
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :title,         presence: true
  validates :location,      presence: true
  validates :description,   presence: true, length: { minimum: 150 }
  validates :instructions,  presence: true
  validates :company,       presence: true
  validates :url,           url: true
  validates :email,         presence: true, format: { with: EMAIL_REGEX }

  default_scope { order('created_at desc') }

  private

    def set_defaults
      self.highlight  ||= false
      self.expires_at ||= Time.now + DURATION
    end
end
