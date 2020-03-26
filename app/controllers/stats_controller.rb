class StatsController < ApplicationController
skip_before_action :require_login
  def posts
    
    @count = Post.where("created_at BETWEEN ? AND ?", "2019-12-31","2020-02-01").group(:user_id).count
    respond_to do |format|
      format.json { render json: @count }
    end    
  end

end
