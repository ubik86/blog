module CommentsHelper

  def comments_size(post)
    post.comments.size
  end

  def p_comments(post)
    post.comments.map{|m| m.desc}.join(',')
  end


  # helper that return link to comment nested in posts /post/1/comment
  def countComLink(post)
    return link_to post.c_quantity, post_comments_path(post)
  end

end
