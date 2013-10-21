require 'money'

class Integer
  def dollars
    Money.new self * 100, 'USD'
  end
  alias :dollar :dollars
end
