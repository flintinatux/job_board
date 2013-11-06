module Uuidentified
  extend ActiveSupport::Concern

  included do
    before_create { self.uuid = SecureRandom.uuid }
  end
end
