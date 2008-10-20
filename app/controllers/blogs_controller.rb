class BlogsController < ApplicationController
  before_filter :get_page_name
	before_filter :verify_bloggable, :except => [:index, :show, :feed]

	# GET /blogs
  # GET /blogs.xml
  def index
		blog_show_params = params[:blog_show_params] || {}
    @blogs = Blog.paginate(:all, :conditions => { :is_indexed => true, :is_complete => true }, :order => "created_at DESC", :page => blog_show_params[:page] || 1, :per_page => 15)
		#set_page_title("Relentless Simplicity - The Bonanzle Blog")
    
		respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @blogs }
    end
  end

  # GET the blog as a feed
	def feed
		@blogs = Blog.find(:all, :conditions => { :is_indexed => true, :is_complete => true }, :order => "created_at DESC")
		render :action => :feed, :layout => false
	end
	
  # GET /blogs/1
  # GET /blogs/1.xml
  def show
    @blogs = Blog.find(:all, :conditions => { :is_indexed => true, :is_complete => true }, :order => "created_at DESC")
    @blog = Blog.find(:first, :conditions => ["id = ? OR url_identifier = ?", params[:id], params[:id]])

		if !@blog || (!@blog.is_complete && !blog_writer?)
			flash[:error] = "You do not have permission to see this blog."
			return (redirect_to( :action => 'index' ))
		else
			set_page_title(@blog.title)
		end
	
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @blog }
    end
  end

  # GET /blogs/new
  # GET /blogs/new.xml
  def new
    @blog = Blog.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @blog }
    end
  end

  # GET /blogs/1/edit
  def edit
    @blog = Blog.find(params[:id])
  end

  # POST /blogs
  # POST /blogs.xml
  def create
		@blog = Blog.new(params[:blog])
	  @blog.posted_by = current_user

		respond_to do |format|
      if @blog.save
        flash[:notice] = 'Blog was successfully created.'
        format.html { redirect_to(@blog) }
        format.xml  { render :xml => @blog, :status => :created, :location => @blog }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @blog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /blogs/1
  # PUT /blogs/1.xml
  def update
    @blog = Blog.find(params[:id])

    respond_to do |format|
			if @blog.update_attributes(params[:blog])
        flash[:notice] = 'Blog was successfully updated.'
        format.html { redirect_to(@blog) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @blog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.xml
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to(blogs_url) }
      format.xml  { head :ok }
    end
  end
	
	# Ensure this user is a legimate editor of blogs, or redirect them
	def verify_bloggable
		unless blog_writer?
			flash[:error] = "You do not have permission to see this blog"
			return (redirect_to( :action => 'index' ))
		end
    true
	end
	
end
