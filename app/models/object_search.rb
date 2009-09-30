class ObjectSearch < ActiveRecord::Base
  acts_as_database_object

  has_field :status
  has_field :search_string
  has_many :found_objects
	
  link_text {|x,c| x.search_string}
end
