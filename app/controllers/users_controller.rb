class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_perishable_token_expiry, only: [:reset_password, :send_password_reset_link]
  skip_before_action :require_login, only: [:forgotten_password, :send_password_reset_link, :reset_password]
  # GET /users
  def index
    @page_title = "Userlista"
    @users = User.all.order("last_request_at DESC NULLS LAST", active: :desc, username: :asc)
  end

  # GET /users/1
  def show
    @font_sizes = FontSize.all.order(value: :desc)
    @posts_per_page_values = PostsPerPage.all.order(value: :desc)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.username.strip!
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Felhasználó elmentve.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Felhasználó módosítva.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.update_attributes(active: false)
#    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Felhasználó inaktív.' }
    end
  end

  def forgotten_password
  end

  def send_password_reset_link
    @user = User.active.find_by_username(params[:username])
    if @user
      @user.reset_perishable_token!
      UserMailer.password_reset_mail(@user.id, @expiry).deliver_now
      flash[:notice] = "Elküldtem a jelszóvisszaállító e-mailt a megadott felhasználó címére (#{@user.email})"
      redirect_to sign_in_path
    else
      flash[:notice] = "Inaktív, vagy nem létező felhasználó"
      redirect_to sign_in_path
    end
  end

  def reset_password

    @user = User.active.find_using_perishable_token(params[:token], @expiry)
    redirect_to root_path, notice: "Nem találom a felhasználót" unless @user
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    if @user.save
      flash[:notice] = "Jelszó beállítása sikeres"
      redirect_to root_path
    else
      render action: :forgotten_password
    end

  end

  def admin_up

    if session[:is_admin] == true
      session[:is_admin] = false
    else
      session[:is_admin] = true
    end
    redirect_back(fallback_location: root_path)

  end

  def set_custom_vars

    if params[:font_size_id]
      current_user.update(font_size_id: params[:font_size_id])
    end
    if params[:posts_per_page_id]
      current_user.update(posts_per_page_id: params[:posts_per_page_id])
    end
    redirect_to current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_perishable_token_expiry
     @expiry = 12.hours
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :username, :name, :active, :password, :password_confirmation, :signature, :font_size_id, :posts_per_page_id)
    end
end
