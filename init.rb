
# Include hook code here
puts "in init.rb ****************************** #{directory}"

path = File.join(directory, 'lib')
$LOAD_PATH << path
Dependencies.load_paths << path

%w{ models controllers helpers views workers command_handlers }.each do |dir|
  path = File.join(directory, 'app', dir)
  $LOAD_PATH << path
  Dependencies.load_paths << path
  Dependencies.load_once_paths.delete(path)
end

unless ObjectDatabaseCommandHandler.find_by_name("SearchAll")
	ObjectDatabaseCommandHandler.new(:prefix => "??", 
												:name => "SearchAll", 
												:is_plugin_source_code => true,
			   								:content => File.read(
									 				File.join(directory, 
														"app/command_handlers/search_all_handler.rb"))
												).save
	ObjectDatabaseModel.new(:name => "ObjectSearch", 
									:is_plugin_source_code => true,
	  								:content => File.read(
						 				File.join(directory, 
										"app/models/object_search.rb"))
							     ).save
	ObjectDatabaseController.new(:name => "ObjectSearch",
										  :is_plugin_source_code => true,
	  								     :content => File.read(
						 				     File.join(directory, 
										        "app/controllers/object_search_controller.rb"))
										  ).save
	ObjectDatabaseHelper.new(:name => "ObjectSearch", 
									 :is_plugin_source_code => true,
	  								     :content => File.read(
						 				     File.join(directory, 
										        "app/helpers/object_search_helper.rb"))
								   ).save
	ObjectDatabaseModel.new(:name => "FoundObject", 
									:is_plugin_source_code => true,
	  								:content => File.read(
						 				File.join(directory, 
										"app/models/found_object.rb"))
							     ).save
	ObjectDatabaseController.new(:name => "FoundObject",
										  :is_plugin_source_code => true,
	  								     :content => File.read(
						 				     File.join(directory, 
										        "app/controllers/found_object_controller.rb"))
										  ).save
	ObjectDatabaseHelper.new(:name => "FoundObject", 
									 :is_plugin_source_code => true,
	  								     :content => File.read(
						 				     File.join(directory, 
										        "app/helpers/found_object_helper.rb"))
								   ).save
end
