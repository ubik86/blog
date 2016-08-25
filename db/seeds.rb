# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# definitions of people
people = [{name: 'bogus', login: 'btr', email: 'btr@example.com'}, {name: 'wiktor', login: 'wru', email: 'wru@example.com'}, {name: 'irek', login: 'ipr', email: 'ipr@example.com'}]

user = User.create(email: 'test@example.com', name: 'Test User', image:'http://graph.facebook.com/v2.6/1062656937103590/picture',  password: 'test123')
user.confirm
post = user.posts.create(title: 'Long post title 1', content: 'Long post content number 1')
comments = 3.times{|i| user.comments.create(desc: "Comment number #{i+1} description", post: post)}


# friendships build
people.each do |p|
  person = Person.create(name: p[:name], login: p[:login], email: p[:email])
  person.tags.create(postable: post, user: user)
end

wiktor = Person.where(name: 'wiktor').first
Person.where(name: 'bogus').first.friendships.create(friend: wiktor, accepted: true, confirmed_at: Time.now)


p "Login with"
p "email: test@example.com"
p "password: test123"