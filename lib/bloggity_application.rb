require 'page_names'

module BloggityApplication
	include PageNames
	
  def get_page_name
  	@page_name = look_up_page_name(params[:controller], params[:action])
  	session['page_name'] = @page_name
  end
  
  def set_page_title(title, options = {})
		session['page_name'] = title
		session['page_name']
	end
end
