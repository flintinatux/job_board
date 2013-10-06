module ApplicationHelper
  def board_icon
    @current_board ? @current_board.icon : 'icon-group'
  end

  def full_title(title=nil)
    base_title = @current_board ? @current_board.title : 'JobBoards.com'
    title.blank? ? base_title : "#{title} | #{base_title}"
  end
end
