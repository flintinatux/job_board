module JobsHelper
  def primary_if(is_primary)
    is_primary ? 'btn-primary' : 'btn-default'
  end
end
