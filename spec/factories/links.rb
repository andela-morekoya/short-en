FactoryGirl.define do
  factory :link do
    original Faker::Internet.url
    user
  end
end
