# == Schema Information
#
# Table name: boards
#
#  id             :integer          not null, primary key
#  subdomain      :string(255)
#  title          :string(255)
#  tagline        :string(255)
#  icon           :string(255)
#  syndicates     :string(255)      default([])
#  suggestions    :string(255)
#  benefits       :text
#  price_cents    :integer          default(0), not null
#  price_currency :string(255)      default("USD"), not null
#  uuid           :string(36)       not null
#  created_at     :datetime
#  updated_at     :datetime
#

class Board < ActiveRecord::Base
  include Parameterized
  include Uuidentified
  parameterize_by :subdomain
  has_many :categories, inverse_of: :board, dependent: :destroy
  monetize :price_cents

  validates :subdomain,   presence: true, uniqueness: { case_sensitive: false }
  validates :title,       presence: true
  validates :tagline,     presence: true
  validates :suggestions, presence: true
  validates :benefits,    presence: true
  validates :price,       numericality: { greater_than_or_equal_to: 1 }

  default_scope { order('title asc') }

  def category_ids
    categories.pluck :id
  end
end
