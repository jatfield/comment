class AddFullTextIndexToPosts < ActiveRecord::Migration[5.0]
  def up
    execute("CREATE INDEX index_posts_on_full_text ON posts USING gin(to_tsvector('hungarian', full_text))")
  end
  def down
    execute("DROP INDEX index_posts_on_full_text")
  end
end
