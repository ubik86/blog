FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'Test123'

  end
end
