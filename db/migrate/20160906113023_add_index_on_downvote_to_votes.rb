class AddIndexOnDownvoteToVotes < ActiveRecord::Migration[5.0]
  def change

    add_index :votes, :downvote

  end
end
