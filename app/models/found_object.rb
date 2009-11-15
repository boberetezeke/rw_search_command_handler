class FoundObject < ActiveRecord::Base
  acts_as_database_object do

    has_field :fo_class
    has_field :fo_id
  end

  belongs_to :object_search
	
  #link_text {|x,c| x.fieldname}
end
