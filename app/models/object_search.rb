class ObjectSearch < ActiveRecord::Base
  acts_as_database_object do

    has_field :status
    has_field :search_string
    has_many :found_objects
  end
	
  link_text {|x,c| x.search_string}
end
