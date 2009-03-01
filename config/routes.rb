ActionController::Routing::Routes.draw do |map|
  map.resources :blogs, :collection => { :feed => :get }
	map.resources :blog_comments
end