class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :log_in_user!, :verify_logged_in

  def current_user
    return nil if session[:session_token].nil?
    @user = User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    current_user && current_user.session_token == session[:session_token]
  end

  def log_in_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def verify_logged_in
    if current_user.nil?
      flash[:errors] = ["Please log in."]
      redirect_to new_session_url
    end
  end
end
