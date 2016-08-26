FactoryGirl.define do
  factory :person do
    sequence(:login) {|n| "login#{n}"}
    name  'John Person'
    email 'john@example.com'
    created_at Time.now.to_date
  end
end
