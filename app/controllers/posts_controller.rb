class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    params[:page] ||= 1
    session[:posts_per_page] ||= 40
    page = params[:page]
    if params[:user_id]
      @user = User.find(params[:user_id])
      @posts = @user.posts.order(created_at: :desc).page(page).per(40).includes(:user, :answer_to, :topic)
    elsif params[:search_term]
      @posts = Post.search(params[:search_term]).order(created_at: :desc).page(page).per(40).includes(:user, :answer_to, :topic)
    else
      @posts = Post.order(created_at: :desc).page(page).per(40).includes(:user, :answer_to, :topic)
 
    end
  
  end

  # GET /posts/1
  # GET /posts/1.json

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @topic = Topic.find(params[:topic_id])
    @user = User.find(params[:user_id])
    @topic.last_post ? number = @topic.last_post.number + 1 : number = 1
    @post = Post.new(full_text: params[:full_text], answer_to_id: params[:answer_to], number: number, topic: @topic, user: @user)

    respond_to do |format|
      if @post.save
        if params[:images] 
          params[:images].each {|i| @post.uploads.create(file: i, user: @post.user)}
        end
        format.html { redirect_to @topic }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params.except!(:user_id))
        format.html { redirect_to @post.topic, notice: 'Hozzászólás módosítva.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Hozzászólás törölve.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:full_text, :user_id, :number, :topic_id, :answer_to_id)
    end
end
