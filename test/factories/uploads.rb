FactoryGirl.define do
  factory :upload do
    user
    post
    file File.new("test/fixtures/test_image.jpg") 
  end
end
