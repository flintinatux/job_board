class BoardsController < ApplicationController
  before_action :signed_in_user
  before_action :find_boards, only: [:index, :show]
  before_action :find_board, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    render 'index'
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
      params[:board].permit :subdomain, :title, :tagline, :icon, :suggestions, :benefits
    end

    def find_board
      @board = Board.find params[:id]
    end

    def find_boards
      @boards = Board.all.includes :categories
    end
end
