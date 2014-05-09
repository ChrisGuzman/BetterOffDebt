class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  add_flash_types :success, :info, :warning, :danger

  protected
  helper_method def logged_in?
    session[:user_id].present?
  end

  def set_current_user(user=nil)
    session[:user_id] = user.try(:id)
  end
end
