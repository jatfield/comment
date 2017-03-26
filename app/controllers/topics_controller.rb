class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.order(updated_at: :desc).all
  end

  # GET /topics/1
  def show
    current_user.topic_visits.create(topic_id: @topic.id)
    load_forecast if @topic.id == 40
    @page_title = @topic.name
    params[:page] ||= 1
    page = params[:page]
    @posts = @topic.posts.order(number: :desc).page(page).per(@posts_per_page).includes({user: :avatar}, :answer_to, :uploads, :upvotes, :downvotes)
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Téma elmentve.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /topics/1
  def update
    respond_to do |format|
      if @topic.update(topic_params.except(:user_id))
        format.html { redirect_to @topic, notice: 'Téma módosítva.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /topics/1
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Téma törölve.' }
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
