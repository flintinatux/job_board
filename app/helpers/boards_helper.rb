module BoardsHelper
  def board_url(board)
    root_url(subdomain: board.subdomain)
  end
end
