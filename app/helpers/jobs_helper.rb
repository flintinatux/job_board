module JobsHelper
  def primary_if(is_primary)
    is_primary ? 'btn-primary' : 'btn-default'
  end

  def job_limit
    20
  end
end
