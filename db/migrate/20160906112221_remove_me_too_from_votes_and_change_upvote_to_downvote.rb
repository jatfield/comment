class RemoveMeTooFromVotesAndChangeUpvoteToDownvote < ActiveRecord::Migration[5.0]
  def change
  
    remove_column :votes, :me_too, :boolean, index: true
    rename_column :votes, :upvote, :downvote
    
  end
end
