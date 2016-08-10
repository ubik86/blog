FactoryGirl.define do
  factory :post do
    title "Post"
    content "Content"
    published false
  	association :user
  end
end
