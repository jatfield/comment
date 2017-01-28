FactoryGirl.define do
  factory :font_size do
    sequence(:value) { |n| n }
    sequence(:name) { |n| "Font size #{n}" }
  end
end
