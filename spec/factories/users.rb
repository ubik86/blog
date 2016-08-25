FactoryGirl.define do
  factory :user do
    email 		{ Faker::Internet.email }
    name      'Test User'
    password 	'Test123'
    password_confirmation "Test123"
    confirmed_at Date.today
  end

  factory :admin, class: User do 
    email 		{ Faker::Internet.email }
    name      'Test User'    
    password 	'Test123'
    password_confirmation "Test123"
    admin 		true
  end
end
