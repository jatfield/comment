class CreatePostsPerPages < ActiveRecord::Migration[5.0]
  def change
    create_table :posts_per_pages do |t|
      t.integer :value

      t.timestamps
    end
  end
end
