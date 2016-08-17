FactoryGirl.define do
  factory :stat do
    posts { create_list(:post, 3) }
    comments { create_list(:comment, 3) }
  end
end
