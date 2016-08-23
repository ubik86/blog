json.user do
  json.name  @user.name
  json.email @user.email
  json.image @user.profile_img
end

json.posts @posts do |p|
  json.id       p.id
  json.title    p.title
  json.content  p.content

  json.comments p.comments do |c|
    json.id   c.id
    json.desc c.desc
  end
end