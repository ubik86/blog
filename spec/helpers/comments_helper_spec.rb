require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the CommentsHelper. For example:
#

post = FactoryGirl.build(:post)

i = 3
i.times{|k| post.comments.build(desc: "comment #{k}")}

RSpec.describe CommentsHelper, type: :helper do
  
  describe "print comments belongs_to post" do
    it "print comments to post" do
      expect(helper.comments_size(post)).to eq(i)
    end

    it "comments belongs_to post" do
      expect(helper.p_comments(post)).to eq(post.comments.map{|m| m.desc}.join(','))
    end
  end
end