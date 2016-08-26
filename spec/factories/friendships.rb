FactoryGirl.define do
  factory :friendship do
    association :person
    association :friend, factory: :person
    created_at Time.now
  end
end
