class JobsController < ApplicationController
  before_action :find_categories, only: [:index]

  def index
  end

  def show
    @category = Category.find params[:category_id]
    @job = @category.jobs.find params[:id]
  end

  def new
  end

  def create
    if job.valid? and card.valid?
      @result = card.charge @current_board.price
      job.save if @result.success?
    end

    head :ok
  end

  def preview
    @job = Job.new job_params
  end

  def search
  end

  def old_new
    @job = Job.new
  end

  private

    def card
      @card ||= Card.new params[:card]
    end

    def find_categories
      if params[:category_id]
        @categories = [ @current_board.categories.find_by(id: params[:category_id]) ]
      else
        @categories = @current_board.categories.includes :jobs
        @categories.reject! { |category| category.jobs.size == 0 }
      end
    end

    def job
      @job ||= Job.new job_params
    end

    def job_params
      params[:job].permit :title, :category_id, :location, :description, :instructions, :highlight, :company, :url, :email
    end
end
