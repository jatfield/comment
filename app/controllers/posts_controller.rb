class PostsController < ApplicationController
  include ActionView::Helpers::TextHelper #so simple_format works to convert mobile text
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  def index
    params[:page] ||= 1
    page = params[:page]
    if params[:user_id]
      @user = User.find(params[:user_id])
      @posts = @user.posts.order(created_at: :desc).page(page).per(@posts_per_page).includes(:user, :answer_to, :topic)
    elsif params[:search_term]
      @posts = Post.search(params[:search_term]).page(page).per(@posts_per_page).includes(:user, :answer_to, :topic)
    else
      @posts = Post.order(created_at: :desc).page(page).per(@posts_per_page).includes(:user, :answer_to, :topic)
 
    end
  
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @topic = Topic.find(params[:topic_id])
    @user = User.find(params[:user_id])
    @topic.last_post ? number = @topic.last_post.number + 1 : number = 1
    params[:full_text] = simple_format(params[:full_text]) if session[:is_mobile]
    @post = Post.new(full_text: params[:full_text], answer_to_id: params[:answer_to], number: number, topic: @topic, user: @user)

    respond_to do |format|
      if @post.save
        if params[:images] 
          params[:images].each {|i| @post.uploads.create(file: i, user: @post.user)}
        end
        format.html { redirect_to @topic }
      else
        format.html { redirect_to @topic }
      end
    end
  end

  # PATCH/PUT /posts/1
  def update
    respond_to do |format|
      if @post.update(post_params.except(:user_id))
        format.html { redirect_to @post.topic, notice: 'Hozzászólás módosítva.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Hozzászólás törölve.' }
    end
  end

  def voter_list
    @post = Post.find(params[:post_id])
    @previous_target = session[:previous_target] unless session[:previous_target] =="#post_voter_list_#{@post.id}"
    @downvotes_by_user = @post.downvotes.includes(:user).group_by { |p| p.user } if @post.downvotes
    @upvotes_by_user = @post.upvotes.includes(:user).group_by { |p| p.user } if @post.upvotes
    respond_to do |format|
      format.js {}
    end
    session[:previous_target] = "#post_voter_list_#{@post.id}"
  end

  def post_chain
    @post = Post.find(params[:post_id])
    respond_to do |format|
      format.js {}
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
