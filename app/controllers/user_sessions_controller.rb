class UserSessionsController < ApplicationController
skip_before_action :require_login, except: :destroy

  def new
    redirect_to root_path if current_user
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(user_session_params)
    @user_session.remember_me = true
    @user_session.username.strip!
    if @user_session.save
#      flash[:notice] = "Bejelentkezés sikeres"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    current_user_session.destroy
    reset_session
#    flash[:notice] = "Kijelentkezett"
    redirect_to root_path
  end

  private

  def user_session_params
    params.require(:user_session).permit(:username, :password, :remember_me)
  end
end
