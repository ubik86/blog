json.user do
  json.name  @user.name
  json.email @user.email
  json.image @user.profile_img
end

json.comments @comments do |c|
  json.id         c.id
  json.desc       c.desc
  json.children   c.children
  json.ancestry   c.ancestry

  json.post  do |p|
    json.title    c.post.title
    json.content  c.post.content
  end
end