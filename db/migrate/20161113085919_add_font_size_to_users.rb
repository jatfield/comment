class AddFontSizeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :font_size, foreign_key: true
  end
end
