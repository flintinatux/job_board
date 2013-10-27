class CategoriesController < ApplicationController
  before_action :signed_in_user, except: [:show]
  before_action :find_board, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_category, only: [:edit, :update, :destroy]

  def show

  end

  def new
    @category = @board.categories.build
  end

  def create
    @category = @board.categories.create category_params
  end

  def edit
  end

  def update
    @category.update_attributes category_params
  end

  def destroy
    @category.destroy
  end

  private

    def category_params
      params[:category].permit :name
    end

    def find_board
      @board = Board.find params[:board_id]
    end

    def find_category
      @category = @board.categories.find params[:id]
    end
end
