class StatsController < ApplicationController

  def index
    @from = params[:from] ? DateTime.parse(params[:from]) : DateTime.now.beginning_of_month
    @to = params[:to] ? DateTime.parse(params[:to]) : DateTime.now.end_of_month
    @count = Post.joins(:user).where("posts.created_at BETWEEN ? AND ?", @from, @to).group(:username).count
  end
end
