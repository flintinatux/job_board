class CategoriesController < ApplicationController
  before_action :find_board, only: [:new, :create, :edit, :update, :destroy]

  def new
    @category = @board.categories.build
  end

  private

    def find_board
      @board = Board.find params[:board_id]
    end
end
