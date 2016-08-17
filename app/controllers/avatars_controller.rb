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
  # POST /avatars.json
  def create
    @avatar = Avatar.new(avatar_params)
    @user = @avatar.user

    respond_to do |format|
      if @avatar.save
        format.html { redirect_to @avatar.user, notice: 'Avatar feltöltve.' }
        format.json { render :show, status: :created, location: @avatar }
      else
        format.html { render :new }
        format.json { render json: @avatar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /avatars/1
  # PATCH/PUT /avatars/1.json
  def update
    respond_to do |format|
      if @avatar.update(avatar_params)
        format.html { redirect_to @avatar.user, notice: 'Avatar cserélve.' }
        format.json { render :show, status: :ok, location: @avatar }
      else
        format.html { render :edit }
        format.json { render json: @avatar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /avatars/1
  # DELETE /avatars/1.json
  def destroy
    @avatar.destroy
    respond_to do |format|
      format.html { redirect_to user_url(@avatar.user), notice: 'Avatar törölve.' }
      format.json { head :no_content }
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
