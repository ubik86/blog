class Comment < ActiveRecord::Base
  belongs_to :post
  has_one :user, through: :post
  has_ancestry        
  paginates_per 5     # 5 objects per page

  validates :post, :desc, presence: true


  # return quantity of childrens
  def childrens
    self.descendants.size
  end
end
