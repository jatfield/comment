class StatsController < ApplicationController

  def index
    @from = params[:from] ? DateTime.parse(params[:from]).beginning_of_month : DateTime.now.beginning_of_month
    @to = params[:to] ? DateTime.parse(params[:to]).end_of_month : DateTime.now.end_of_month
    order = params[:order] == "user" ? 'username asc' : 'count_all desc'
    @count = Post.joins(:user).where("posts.created_at BETWEEN ? AND ?", @from, @to).group(:username).order(order).count
    @sum_count = Post.where("posts.created_at BETWEEN ? AND ?", @from, @to).count
    @post_count = ActiveRecord::Base.connection.execute("select date_part('month', created_at) as month, count(*) as post_count from posts where created_at between '#{@from.strftime("%Y") + '-01-01 00:00:01'}' and '#{@from.strftime("%Y") + '-12-31 23:59:59'}' group by month order by month")
  end
end
