class UploadsController < ApplicationController
  before_action :set_upload, only: [:destroy]

  # GET /uploads
  # GET /uploads.json
  def index
    if params[:user_id]
      @uploads_by_post = User.find(params[:user_id]).uploads.group_by { |u| u.post }
    elsif params[:post_id]
      @uploads_by_post = Post.find(params[:post_id]).uploads.group_by { |u| u.post }
    else
      @uploads_by_post = Upload.all.group_by { |u| u.post }
    end
  end


  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, notice: 'File törölve.')}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_params
      params.require(:upload).permit(:user_id, :post_id)
    end
end
