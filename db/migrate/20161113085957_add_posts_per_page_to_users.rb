class AddPostsPerPageToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :posts_per_page, foreign_key: true
  end
end
