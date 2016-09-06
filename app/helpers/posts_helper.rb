module PostsHelper

  def print_user(post)
    post.user.email
  end 

  def show_comments(post)
    post.comments
  end

  def find_taggable(content)
    Post.find_taggable(content)
  end
end
