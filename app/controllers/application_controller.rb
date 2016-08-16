class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user_session, :current_user, :is_admin?
  before_action :require_login
private 

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def is_admin?
    session[:is_admin] if current_user
  end

  def require_login
    unless current_user
       flash[:notice] = "Bejelentkezés szükséges"
      redirect_to sign_in_url
    end
  end

end
