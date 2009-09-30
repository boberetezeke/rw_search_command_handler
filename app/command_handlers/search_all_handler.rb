class SearchAllHandler < ODRails::CommandHandler
  def handle_command(command_str)
    session[:search_job_key] = MiddleMan.new_worker(:class => "search_worker")
    search_id = MiddleMan.get_worker(session[:search_job_key]).search_all(command_str)
    redirect_to :controller => "object_search", :action => "show", :id => search_id
  end
end