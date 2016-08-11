require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PostsHelper. For example:
#
# describe PostsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end

user = FactoryGirl.build(:user)
post = FactoryGirl.build(:post)

RSpec.describe PostsHelper, type: :helper do
  describe "print user belongs_to post" do
    it "print user email" do
      expect(helper.print_user(post)).to eq(post.user.email)
    end

    it "give comments belongs_to post" do
      expect(helper.show_comments(post)).to eq(post.comments)
    end
  end
end
