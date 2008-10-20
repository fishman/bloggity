# == Schema Information
# Schema version: 119
#
# Table name: blog_assets
#
#  id           :integer(11)     not null, primary key
#  blog_id      :integer(11)     
#  parent_id    :integer(11)     
#  content_type :string(255)     
#  filename     :string(255)     
#  thumbnail    :string(255)     
#  size         :integer(11)     
#  width        :integer(11)     
#  height       :integer(11)     
#

class BlogAsset < ActiveRecord::Base
	belongs_to :blog
	 
end
