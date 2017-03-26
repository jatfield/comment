class AvatarsController < ApplicationController
  before_action :set_avatar, only: [:edit, :update, :destroy]

  # GET /avatars/new
  def new
    @user = User.find(params[:user_id])
    @avatar = Avatar.new
  end

  # GET /avatars/1/edit
  def edit
    @user = @avatar.user
  end

  # POST /avatars
  def create
    @avatar = Avatar.new(avatar_params)
    @user = @avatar.user

    respond_to do |format|
      if @avatar.save
        format.html { redirect_to @avatar.user, notice: 'Avatar feltöltve.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /avatars/1
  def update
    respond_to do |format|
      if @avatar.update(avatar_params)
        format.html { redirect_to @avatar.user, notice: 'Avatar cserélve.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /avatars/1
  def destroy
    @avatar.destroy
    respond_to do |format|
      format.html { redirect_to user_url(@avatar.user), notice: 'Avatar törölve.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_avatar
      @avatar = Avatar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def avatar_params
      params.require(:avatar).permit(:user_id, :picture)
    end
end
