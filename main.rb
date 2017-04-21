require 'xcodeproj'
require 'nokogiri'
require 'open-uri'
require './Entity.rb'
require './Attribute.rb'
require './Relationship.rb'
require './Type.rb'
require './Entities/Entity + Template.rb'
require 'liquid'
require './XcodeprojHelper.rb'
require './ModelReader.rb'
require './Entities/HeaderTemplate.rb'

data_model_path = ARGV[0]

project_paths = Dir["*.xcodeproj"] # PROJECT.xcodeproj

if project_paths.length > 2
	puts "There are more than 1 .xcodeproj files. Abort"
	exit 1
end

project_path = project_paths.first

project = XcodeprojHelper::openProject(project_path)
project_name = project_paths.first.split("/").last.split(".").first

entities = ModelReader::readEntities(data_model_path)

group = XcodeprojHelper::addGroup(project_name, project, "Test_generated")
some_group = XcodeprojHelper::addGroup(project_name, project, "Some", group)

entities.each do |entity|

	properties_array = Array.new
	entity.attributes.each do |attribute|
		properties = Hash.new
		attribute.instance_variables.each {|x| properties[x[1..-1]] = attribute.instance_variable_get(x) }
		properties_array.push(properties)
	end

	rel_array = Array.new
	entity.relationships.each do |relationship|
		rel = Hash.new
		relationship.instance_variables.each {|x| rel[x[1..-1]] = relationship.instance_variable_get(x) }
		rel_array.push(rel)
	end

	file_name = "#{entity.name}.swift"
	header = HeaderTemplate::generateHeader(project_name, file_name)
	content =  EntityTemplate::generateTemplate(entity, header, entities)
	XcodeprojHelper::add_file(file_name, content, group, project_name, project)
end