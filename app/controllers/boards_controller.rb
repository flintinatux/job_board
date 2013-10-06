class BoardsController < ApplicationController
  before_action :find_board, only: [:edit, :update, :destroy]

  def index
    @boards = Board.all.includes(:categories)
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.create board_params
  end

  def edit
  end

  def update
    @board.update_attributes board_params
  end

  def destroy
    @board.destroy
  end

  private

    def board_params
      params[:board].permit :subdomain, :title, :tagline, :icon
    end

    def find_board
      @board = Board.find params[:id]
    end
end
