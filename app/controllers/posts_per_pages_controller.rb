class PostsPerPagesController < ApplicationController
  before_action :set_posts_per_page, only: [:show, :edit, :update, :destroy]

  # GET /posts_per_pages
  def index
    @posts_per_pages = PostsPerPage.all
  end

  # GET /posts_per_pages/1
  def show
  end

  # GET /posts_per_pages/new
  def new
    @posts_per_page = PostsPerPage.new
  end

  # GET /posts_per_pages/1/edit
  def edit
  end

  # POST /posts_per_pages
  def create
    @posts_per_page = PostsPerPage.new(posts_per_page_params)

    respond_to do |format|
      if @posts_per_page.save
        format.html { redirect_to @posts_per_page, notice: 'Posts per page was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /posts_per_pages/1
  def update
    respond_to do |format|
      if @posts_per_page.update(posts_per_page_params)
        format.html { redirect_to @posts_per_page, notice: 'Posts per page was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /posts_per_pages/1
  def destroy
    @posts_per_page.destroy
    respond_to do |format|
      format.html { redirect_to posts_per_pages_url, notice: 'Posts per page was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_posts_per_page
      @posts_per_page = PostsPerPage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def posts_per_page_params
      params.require(:posts_per_page).permit(:value)
    end
end
