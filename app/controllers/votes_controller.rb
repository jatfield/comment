class VotesController < ApplicationController
  # POST /votes
  def create
    @vote = Vote.new(vote_params)
    @post = @vote.post
    respond_to do |format|
      if @vote.save
        @downvotes_by_user = @post.downvotes.includes(:user).group_by { |p| p.user } if @post.downvotes
        @upvotes_by_user = @post.upvotes.includes(:user).group_by { |p| p.user } if @post.upvotes
        current_user.topic_visits.create(topic_id: @post.topic.id)
        format.html { redirect_back(fallback_location: root_path) }
        format.js {}
      else
        format.html { render :new }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:user_id, :post_id, :downvote)
    end
end
