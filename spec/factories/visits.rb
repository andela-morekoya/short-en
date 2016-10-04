FactoryGirl.define do
  factory :visit do
    link
    user
    address Faker::Internet.ip_v4_address
  end
end
