require 'page_names'

module BloggityApplication
	include PageNames
	
	# Implement in your application
	def current_user
		User.find(1)
	end
	
	def logged_in?
  	current_user && current_user.logged_in?
	end
	
	def blog_writer?
  	current_user && current_user.blog_author?
  end	

  def get_page_name
  	@page_name = look_up_page_name(params[:controller], params[:action])
  end
  
  def set_page_title(title, options = {})
		@page_name = title
	end
	

end
