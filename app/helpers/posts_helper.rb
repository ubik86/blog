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

  # params: new_content, old_content
  def diff_tags(content1, content2)
    new_content = content1
    old_content = content2

    new_tags = find_taggable(new_content)
    old_tags = find_taggable(old_content)
  end
end
