FactoryGirl.define do
  factory :user do
    email "MyString"
    username "MyString"
    name "MyString"
    active false
    crypted_password "MyString"
    password_salt "MyString"
    persistence_token "MyString"
    perishable_token "MyString"
    login_count 1
    last_request_at "2016-08-12 10:44:29"
    current_login_at "2016-08-12 10:44:29"
    last_login_at "2016-08-12 10:44:29"
    current_login_ip "MyString"
    last_login_ip "MyString"
  end
end
