class AddMeTooToVotes < ActiveRecord::Migration[5.0]
  def change
    add_column :votes, :me_too, :boolean, default: false
    add_index :votes, :me_too
  end
end
