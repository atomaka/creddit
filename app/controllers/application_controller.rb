# controllers/application_controller.rb
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_session
  helper_method :logged_in?

  private

  def current_user
    @current_user ||= User.find(current_session[:user_id]) if current_session
  end

  def current_session
    @current_session ||= UserSession.authenticate(cookies[:user_session])
  end

  def logged_in?
    !!current_user
  end
end
