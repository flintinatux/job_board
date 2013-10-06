class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :find_current_board

  private
    include SessionsHelper

    def find_current_board
      @current_board = subdomain.present? ? Board.find_by(subdomain: subdomain) : nil
    end

    def subdomain
      params[:subdomain] || request.subdomain
    end
end
