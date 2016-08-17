FactoryGirl.define do

  factory :post do
    user 
    topic
    full_text "MyText"
    sequence(:number) { |n| n }
    answer_to nil 
  end

end
