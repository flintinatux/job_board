module Parameterized
  extend ActiveSupport::Concern

  module ClassMethods
    def parameterized_by(param)
      define_method :to_param do
        persisted? ? "#{id}-#{send(param).parameterize}" : nil
      end
    end
  end
end
