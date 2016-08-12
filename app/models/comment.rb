

class Comment < ActiveRecord::Base
  belongs_to :post
  has_one :user, through: :post
  has_ancestry 

  #has_many :children, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy


end
