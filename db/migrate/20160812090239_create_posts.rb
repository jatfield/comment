class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :full_text
      t.references :user, foreign_key: true
      t.integer :number
      t.references :topic, foreign_key: true
      t.integer :answer_to_id

      t.timestamps
    end
    add_index :posts, :answer_to_id
  end
end
