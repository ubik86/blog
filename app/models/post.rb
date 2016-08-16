class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user
  paginates_per 5

  validates :title, :content, presence: true

  # override search within two fields content and title
  def self.search(search)
    where(["title LIKE ?  OR content LIKE ? ", "%#{search}%", "%#{search}%"]).page
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
