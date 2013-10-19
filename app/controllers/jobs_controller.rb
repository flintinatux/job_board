class JobsController < ApplicationController
  def index
  end

  def new
  end

  def create
    if job.valid? and credit_card.valid?
      @result = credit_card.charge @current_board.price
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

    def credit_card
      @credit_card ||= CreditCard.new params[:credit_card]
    end

    def job
      @job ||= Job.new job_params
    end

    def job_params
      params[:job].permit :title, :category_id, :location, :description, :instructions, :highlight, :company, :url, :email
    end
end
