FactoryGirl.define do
  factory :person do
    login 'login'
    name  'John Person'
    email 'john@example.com'
    created_at Time.now.to_date
  end
end
