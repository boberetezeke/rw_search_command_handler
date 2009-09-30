require "my/mystring"

class ObjectSearchController < ObjectDatabaseModelSuperclassController
  acts_as_metadata_crud_controller ObjectSearch

  def show
    _show(false)
  end

  def update
    object_search = ObjectSearch.find(params["id"])
    # make sure not to send html but text/plain
    headers["Content-Type"] = "text/x-json; charset=utf-8" 

    html = render_to_string(
             :partial => "found_objects", 
             :object => object_search.found_objects,
             :locals => {
               :status => object_search.status
             }
           )

    data = {
      'status' => object_search.status,
      'html' => html
    }

    # this is not the way to do it in prototype 1.5.1
    headers["X-JSON"] = data.to_json 

    render :text => data.to_json
  end
end
