FactoryGirl.define do
  factory :tag do
    association :postable, factory: :post 
    association :user
    association :person

    confirmed_at Time.now
    created_at Time.now
  end
end
