# Put your code that runs your task inside the do_work method
# it will be run automatically in a thread. You have access to
# all of your rails models if you set load_rails to true in the
# config file. You also get @logger inside of this class by default.
class SearchWorker < BackgrounDRb::Rails
  
  def do_work(args)
    # This method is called in it's own new thread when you
    # call new worker. args is set to :args
    puts "created search_worker"
  end

  def search_all(search_string)
     puts "in search all with '#{search_string}'"
    object_search = ObjectSearch.new(:search_string => search_string, 
                                     :status => "in progress")
    object_search.save

    Thread.new do    
      models = ObjectDatabaseModel.find(:all)

      models.each do |model|
        puts "about to search model '#{model.name}'"
        begin
          objects = model.name.constantize.find_by_contents(search_string)
          objects.each do |o| 
            FoundObject.new(:fo_class => o.class.to_s, 
                            :fo_id => o.attributes["id"], 
                            :object_search => object_search).save
          end
        rescue Exception => e
          puts "got exception: #{e.message}"
          puts "backtrace: " + e.backtrace.join("\n")
        end
      end
      puts "done searching"

      object_search.status = "completed"
      object_search.save
    end

    return object_search.attributes["id"]
  end

  def search_one(search_string, model_name)
    
  end
end
