class StatsController < ApplicationController

  def index
    @from = params[:from] ? DateTime.parse(params[:from]).beginning_of_month : DateTime.now.beginning_of_month
    @to = params[:to] ? DateTime.parse(params[:to]).end_of_month : DateTime.now.end_of_month
    @count = Post.joins(:user).where("posts.created_at BETWEEN ? AND ?", @from, @to).group(:username).count
    @sum_count = Post.where("posts.created_at BETWEEN ? AND ?", @from, @to).count
  end
end
