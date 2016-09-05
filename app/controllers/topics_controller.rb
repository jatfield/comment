class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.order(updated_at: :desc).all.includes(:user)
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    session[:visited_topics][@topic.id] = Time.now
    load_forecast if @topic.id == 40
    @page_title = @topic.name
    params[:page] ||= 1
    session[:posts_per_page] ||= 40
    page = params[:page]
    posts_per_page = session[:posts_per_page]
    @posts = @topic.posts.order(number: :desc).page(page).per(posts_per_page).includes(:user, :answer_to)
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Téma elmentve.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params.except!(:user_id))
        format.html { redirect_to @topic, notice: 'Téma módosítva.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Téma törölve.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end
    
    def load_forecast
      @times = []
      @levels = []
        forecast = Nokogiri::HTML(open("http://www.hydroinfo.hu/Html/hidelo/tisza_graf.php", read_timeout: 5))
        tiszabecs = forecast.at_css('map')
        levels_with_times = []
        tiszabecs.css('area')[-25,23].each do |t|
          levels_with_times << t['title']
        end
        levels_with_times.values_at(0,2,3,6,7,10,11,14,15,18,19).each do |l|
          shortened_time = l.split(',')[0].split('.')
          shortened_time.shift
             
          @times << shortened_time.join('.')
          @levels << l.split(',')[1].split[0]
        end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:name, :description, :user_id)
    end
end
