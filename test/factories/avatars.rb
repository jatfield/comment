FactoryGirl.define do
  factory :avatar do
    user
    picture File.new("test/fixtures/test_avatar.png") 
  end
end
