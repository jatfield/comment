class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user_session, :current_user, :is_admin?
  before_action :require_login, :set_session_defaults, :detect_mobile
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
  
  def set_session_defaults

    current_user && current_user.font_size ? @font_size = "#{current_user.font_size.value.to_s}%" : @font_size = "120%"
    current_user && current_user.posts_per_page ? @posts_per_page = current_user.posts_per_page.value : @posts_per_page = 40

  end

  def detect_mobile

    #request.user_agent =~ /android|blackberry|iphone|ipad|ipod|iemobile|mobile|webos/i ? session[:is_mobile] = true : session[:is_mobile] = false
    android_version = request.user_agent.match(/Android [\d+\.]{3,5}/) ? request.user_agent.match(/Android [\d+\.]{3,5}/)[0].delete('Android ').split('.')[0].to_i : false
    session[:is_old_android] = android_version && android_version < 4 ? true : false
  end


end
