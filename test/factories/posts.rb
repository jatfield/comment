FactoryGirl.define do
  factory :post do
    full_text "MyText"
    user nil
    number 1
    topic nil
    answer_to_id 1
  end
end
