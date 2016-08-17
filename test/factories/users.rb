FactoryGirl.define do
#  salt = Authlogic::Random.hex_token
  factory :user do
    sequence(:username) { |n| "User_#{n}" }
    email { "#{username}@provider.com" }
    name "User János"
    active true
    password "janosakiraly"
    password_confirmation { password}
    login_count 0
    last_request_at "2016-08-12 10:44:29"
    current_login_at "2016-08-12 10:44:29"
    last_login_at "2016-08-12 10:44:29"
#    password_salt salt
#    crypted_password Authlogic::CryptoProviders::Sha512.encrypt("janosakiraly" + salt) 
#    persistence_token Authlogic::Random.hex_token 
#    perishable_token Authlogic::Random.friendly_token 
#    current_login_ip 
#    last_login_ip 
  end
end
