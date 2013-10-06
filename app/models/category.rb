# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  board_id   :integer
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  include Parameterized
  parameterize_by :name
  belongs_to :board
  # has_many :jobs

  validates :name, presence: true

  default_scope { order('name asc') }
end
