FactoryGirl.define do
  factory :person do
    association :user

    sequence(:login) {|n| "login#{n}"}
    name  'John Person'
    email 'john@example.com'

    created_at Time.now.to_date
  end
end
