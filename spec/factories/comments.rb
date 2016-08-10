
FactoryGirl.define do
  factory :comment do
    desc "MyString"
    association :post
    #association :children
  end
end
