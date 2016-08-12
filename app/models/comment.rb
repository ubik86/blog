

class Comment < ActiveRecord::Base
  belongs_to :post
  has_one :user, through: :post
  has_ancestry


  # return quantity of childrens
  def childrens
    self.descendants.size
  end
end
