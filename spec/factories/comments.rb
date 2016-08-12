
FactoryGirl.define do
  factory :comment do
    desc "MyString"
    association :post
  end
end
