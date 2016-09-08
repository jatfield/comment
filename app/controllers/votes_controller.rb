class VotesController < ApplicationController
  # POST /votes
  # POST /votes.json
  def create
    @vote = Vote.new(vote_params)
    @post = @vote.post
    respond_to do |format|
      if @vote.save
        session[:visited_topics][@post.topic.id] = Time.now
        format.html { redirect_back(fallback_location: root_path) }
        format.json { render :show, status: :created, location: @vote }
        format.js {}
      else
        format.html { render :new }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
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
