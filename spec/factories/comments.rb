
FactoryGirl.define do
  factory :comment do
    desc "MyString"
    association :post
    created_at Time.now
  end
end
