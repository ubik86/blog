FactoryGirl.define do
  factory :post do
    title "Post"
    content "Content"
    published false
    association :user
    created_at Time.now.to_date
  end
end
