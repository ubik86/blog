module CommentsHelper

  def comments_size(post)
    post.comments.size
  end

  def p_comments(post)
    post.comments.map{|m| m.desc}.join(',')
  end
end
