class AddSignatureToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :signature, :text
  end
end
