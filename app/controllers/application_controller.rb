class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  def logged_in?
    current_user.nil? ? false : true
  end

  def prevent_unauthorized_user_access
    redirect_to root_path, notice: 'sorry, you cannot access that page', status: :found unless logged_in?
  end

  def prevent_logged_in_user_access
    redirect_to root_path, notice: 'sorry, you cannot access that page', status: :found if logged_in?
  end

  helper_method :current_user, :logged_in?
end
