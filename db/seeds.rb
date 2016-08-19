# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(email: 'test@example.com', name: 'Test User', image:'http://graph.facebook.com/v2.6/1062656937103590/picture',  password: 'test123')
post = user.posts.create(title: 'Long post title 1', content: 'Long post content number 1')
comments = 3.times{|i| post.comments.create(desc: "Comment number #{i+1} description")}

p "Login with"
p "email: test@example.com"
p "password: test123"