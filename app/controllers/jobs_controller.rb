class JobsController < ApplicationController

  def index
    params[:category_id] ? load_jobs_for_one_category : load_jobs_for_all_categories
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

  def feed
    params[:category_id] ? load_recent_jobs_for_category : load_recent_jobs_for_board
  end

  def search
    params[:term].present? ? search_for_jobs : load_jobs_for_all_categories
    render 'index'
  end

  private

    def card
      @card ||= Card.new params[:card]
    end

    def total_jobs_for_each_category
      @total_jobs = Job.unscoped.live.where(category_id: @current_board.category_ids).group(:category_id).count
    end

    def job
      @job ||= Job.new job_params
    end

    def job_params
      params[:job].permit :title, :category_id, :location, :description, :instructions, :highlight, :company, :url, :email
    end

    def load_all_jobs
      @jobs = Job.where category_id: @current_board.category_ids
    end

    def load_categories_with_jobs
      @categories = @current_board.categories.where id: @jobs.map(&:category_id).uniq
    end

    def load_jobs_for_all_categories
      load_all_jobs
      load_categories_with_jobs
      total_jobs_for_each_category
      @limited = true
    end

    def load_jobs_for_one_category
      @category = @current_board.categories.find params[:category_id]
      @categories = [ @category ]
      @jobs = @category.jobs.prioritized
      @total_jobs = { @category.id => @jobs.length }
    end

    def load_recent_jobs_for_board
      @jobs = Job.where(category_id: @current_board.category_ids).limit(25)
    end

    def load_recent_jobs_for_category
      @category = @current_board.categories.find params[:category_id]
      @jobs = @category.jobs.limit(25)
    end

    def search_for_jobs
      @jobs = Job.search(params[:term]).live.newest.prioritized
      load_categories_with_jobs
      total_jobs_for_each_category
    end
end
