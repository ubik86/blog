class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :tags, as: :postable, dependent: :destroy 
  has_many :people, through: :tags

  belongs_to :user
  paginates_per 5

  validates :title, :content, presence: true

  # override search within two fields content and title
  def self.search(search)
    where(["title LIKE ?  OR content LIKE ? ", "%#{search}%", "%#{search}%"]).page
  end

  # return quantity of comments and all childrens
  def c_quantity
    self.comments.size
  end


  # find tagged people (@login) from Post.content
  # return hash {found: [Person], not_found: [String]}
  def self.find_taggable(content)
    tags = content.scan(/@\w+/)
    logins  = tags.map{|i| i.sub('@','')}
    found, not_found = [],[] 
    
    Person.where(login: logins)

    logins.each do |login|
      person = Person.where(login: login).first
      if person.nil?
        not_found << login
      else
        found << person
      end
    end

    {found: found, not_found: not_found} 
  end

end
