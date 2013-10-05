module SessionsHelper
  # def domain_or_site
  #   @domain || @site
  # end

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = { value: user.remember_token } #, domain: domain_or_site.domain }
    current_user = user
  end

  def signed_in?
    current_user.present?
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by remember_token: cookies.signed[:remember_token]
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    current_user = nil
    cookies.delete :remember_token #, domain: domain_or_site.domain
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete :return_to
  end

  def store_location
    session[:return_to] = request.fullpath
  end
end
