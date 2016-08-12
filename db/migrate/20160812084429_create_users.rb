class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :name
      t.boolean :active, default: false
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :perishable_token
      t.integer :login_count, default: 0, null: false
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string :current_login_ip
      t.string :last_login_ip

      t.timestamps
    end
  end
end
