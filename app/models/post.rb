class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user


  validates :title, :content, presence: true

  def self.search(search)
    where(["title LIKE ?  OR content LIKE ? ", "%#{search}%", "%#{search}%"])
  end


  # return quantity of comments and all childrens
  def c_quantity
    quantity=0 

    self.comments.each do |c|
      quantity += 1 + c.descendants.size
    end
    quantity
  end
end
