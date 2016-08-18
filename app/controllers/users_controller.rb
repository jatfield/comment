class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_user_using_perishable_token, only: [:reset_password ]
  skip_before_action :require_login, only: [:forgotten_password, :send_password_reset_link, :reset_password]
  # GET /users
  # GET /users.json
  def index
    @users = User.all.order(username: :asc)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Felhasználó elmentve.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Felhasználó módosítva.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.update_attributes(active: false)
#    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Felhasználó inaktív.' }
      format.json { head :no_content }
    end
  end

  def forgotten_password
  end

  def send_password_reset_link
    @user = User.active.find_by_username(params[:username])
    if @user
      @user.reset_perishable_token!
      UserMailer.password_reset_mail(@user.id).deliver_now
      flash[:notice] = "Elküldtem az jelszóvisszaállító e-mailt a megadott felhasználónak"
      redirect_to sign_in_path
    else
      flash[:notice] = "Inaktív, vagy nem létező felhasználó"
      redirect_to sign_in_path
    end
  end

  def reset_password

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

    session[:is_admin] = true
    redirect_back(fallback_location: root_path)

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_user_using_perishable_token
      @user = User.find_using_perishable_token(params[:token])
      redirect_to root_path, notice: "Nem találom a felhasználót" unless @user
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :username, :name, :active, :password, :password_confirmation, :signature)
    end
end
