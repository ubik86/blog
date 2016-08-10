FactoryGirl.define do
  factory :user do
    email 		{ Faker::Internet.email }
    password 	'Test123'
  end

  factory :admin, class: User do 
  	email 		{ Faker::Internet.email }
    password 	'Admin123'
    admin 		true
  end
end
