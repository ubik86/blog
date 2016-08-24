
FactoryGirl.define do
  factory :comment do
    desc "MyString"
    association :post
    association :user
    created_at Time.now
  end
end
