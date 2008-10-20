# == Schema Information
# Schema version: 182
#
# Table name: blogs
#
#  id             :integer(11)     not null, primary key
#  title          :string(255)     
#  body           :text            
#  is_indexed     :boolean(1)      
#  tags           :string(255)     
#  posted_by_id   :integer(11)     
#  is_complete    :boolean(1)      
#  created_at     :datetime        
#  updated_at     :datetime        
#  url_identifier :string(255)     
#  category_id    :integer(11)     
#

class Blog < ActiveRecord::Base
	belongs_to :posted_by, :class_name => 'User'
  has_many :comments, :class_name => 'BlogComment', :foreign_key => :record_id
	has_many :assets, :class_name => 'BlogAsset'
	
	xss_terminate :except => [ :body ]
	before_save :update_url_identifier
	
	def update_url_identifier
		self.url_identifier = self.title.strip.gsub(/\W/, '_')
		true
	end
end
