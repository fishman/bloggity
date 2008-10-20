class BlogCommentsController < ApplicationController

  # POST /blogs_comments
	# POST /blogs_comments.xml
	def create
		@blog_comment = BlogComment.new(params[:blog_comment])
		@blog_comment.user_id = current_user.id
		
		respond_to do |format|
			if @blog_comment.save
				@blog = @blog_comment.blog
				flash[:notice] = 'Blog comment was successfully created.'
				format.html { redirect_to(@blog) }
				format.xml  { render :xml => @blog, :status => :created, :location => @blog }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @blog.errors, :status => :unprocessable_entity }
			end
		end
	end
	
end
