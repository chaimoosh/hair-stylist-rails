class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin
    user = User.find_by(id: session[:user_id])
    if user == nil || user.admin != true
      flash[:notice] = "You don't have access to that page"
      redirect_to'/'
    end
  end

  def require_login
    unless logged_in?
      flash[:notice] = "You must login to view that page"
      redirect_to '/'
    end
  end

  def logged_in?
    session[:user_id]
  end
end
