class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :tags, as: :postable, dependent: :destroy 
  has_many :people, through: :tags

  belongs_to :user, touch: true
  paginates_per 5

  validates :title, :content, presence: true

  # override search within two fields content and title
  def self.search(search)
    where(["title LIKE ?  OR content LIKE ? ", "%#{search}%", "%#{search}%"]).page nil
  end

  # return quantity of comments and all childrens
  def c_quantity
    self.comments.size
  end

  def cache_search(search)
    Rails.cache.fetch("#{cache_key}/cache_search", expires_in: 12.hours) do
      Post.all
    end 
  end

  # find tagged people (@login) from Post.content
  # return hash {found: [Person], not_found: [String]}
  def self.find_taggable(content)
    tags = content.scan(/@\w+/)
    logins  = tags.map{|i| i.sub('@','')}
    found, not_found = [],[] 
    
    people = Person.where(login: logins)

    logins.each do |login|
      person = people.select{|p| p.login == login}.first
      if person.nil?
        not_found << login
      else
        found << person
      end
    end

    {found: found, not_found: not_found} 
  end

end
