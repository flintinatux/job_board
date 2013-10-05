class SessionsController < ApplicationController
  def new
    if signed_in?
      flash[:success] = 'You are already signed in.'
      redirect_to root_path
    end
  end

  def create
    user = User.find_by email: params[:email].downcase
    if user && @authenticated = user.authenticate(params[:password])
      sign_in user
    else
      flash.now[:danger] = 'Invalid email/password combination.'
    end
  end

  def destroy
    sign_out
  end
end
