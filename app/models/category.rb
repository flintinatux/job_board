# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  board_id   :integer
#  name       :string(255)
#  uuid       :string(36)       not null
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  include Parameterized
  include Uuidentified
  parameterize_by :full_name
  belongs_to :board
  has_many :jobs, inverse_of: :category, dependent: :destroy

  validates :name, presence: true

  default_scope { order('updated_at desc') }

  def full_name
    "#{name} jobs"
  end
end
