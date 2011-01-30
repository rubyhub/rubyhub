class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :session_expiration
  after_filter :prepare_unobtrusive_flash

  helper_method :current_user


private
  def session_expiration
    request.session_options[:expire_after] = 30.days
  end


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    redirect_to(root_url, :error => 'Требуется авторизация') unless current_user
  end
end
