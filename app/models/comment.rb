class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  
  has_ancestry        
  paginates_per 5     # 5 objects per page

  validates :post, :desc, :user, presence: true


  # return quantity of childrens
  def childrens
    self.descendants.size
  end
end
