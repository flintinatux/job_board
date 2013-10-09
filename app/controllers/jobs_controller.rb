class JobsController < ApplicationController
  def index
  end

  def new
    @job = Job.new
  end

  def preview
    @job = Job.new job_params
  end

  def search
  end

  private

    def job_params
      params[:job].permit :title, :category_id, :location, :description, :instructions, :highlight, :company, :url, :email
    end
end
