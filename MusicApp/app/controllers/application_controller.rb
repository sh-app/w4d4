class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def log_in!(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
  end

  def log_out!
    current_user.reset_session_token!
    @current_user = nil
    session[:session_token] = nil
  end

  def force_login
    unless logged_in?
      flash[:errors] = ["Sorry, must be logged in to view this page"]
      redirect_to new_session_url
    end
  end

end
