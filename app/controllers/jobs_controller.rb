class JobsController < ApplicationController
  def index
  end

  def new
  end

  def create

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

    def job_params
      params[:job].permit :title, :category_id, :location, :description, :instructions, :highlight, :company, :url, :email
    end
end
