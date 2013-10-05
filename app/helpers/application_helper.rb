module ApplicationHelper
  def full_title(title=nil)
    base_title = 'Medical Jobs'
    title.blank? ? base_title : "#{title} | #{base_title}"
  end
end
