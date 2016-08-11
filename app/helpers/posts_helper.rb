module PostsHelper

	def print_user(post)
		post.user.email
	end 

	def show_comments(post)
		post.comments
	end
end
