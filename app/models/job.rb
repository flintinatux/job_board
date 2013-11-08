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
#  highlight    :boolean          default(FALSE)
#  company      :string(255)
#  url          :string(255)
#  email        :string(255)
#  uuid         :string(36)       not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Job < ActiveRecord::Base
  include Parameterized
  include PgSearch
  include Uuidentified

  parameterize_by :title
  pg_search_scope :search, against: [:title, :location, :description, :instructions, :company], using: { tsearch: { prefix: true } }
  belongs_to :category, touch: true
  before_create :set_expiration

  DURATION = 30.days
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :title,         presence: true
  validates :location,      presence: true
  validates :description,   presence: true
  validates :instructions,  presence: true
  validates :company,       presence: true
  validates :url,           url: true
  validates :email,         presence: true, format: { with: EMAIL_REGEX }

  scope :expired,     -> { where 'expires_at < ?',  Time.now }
  scope :live,        -> { where 'expires_at >= ?', Time.now }
  scope :newest,      -> { order 'created_at desc' }
  scope :prioritized, -> { order 'highlight desc'  }

  default_scope { live.newest }

  private

    def set_expiration
      self.expires_at ||= Time.now + DURATION
    end
end
