FactoryGirl.define do
  factory :posts_per_page do
    sequence(:value) { |n| n }
  end
end
