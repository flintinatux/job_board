# == Schema Information
#
# Table name: boards
#
#  id         :integer          not null, primary key
#  subdomain  :string(255)
#  title      :string(255)
#  tagline    :string(255)
#  icon       :string(255)
#  syndicates :string(255)      default([])
#  created_at :datetime
#  updated_at :datetime
#

class Board < ActiveRecord::Base
  include Parameterized
  parameterize_by :subdomain
  has_many :categories, inverse_of: :board, dependent: :destroy

  validates :subdomain, presence: true, uniqueness: { case_sensitive: false }
  validates :title,     presence: true
  validates :tagline,   presence: true

  default_scope { order('title asc') }
end
