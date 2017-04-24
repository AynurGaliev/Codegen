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

bisness_logic_group = XcodeprojHelper::addGroup(project_name, project, "Business Logic")
entities_group = XcodeprojHelper::addGroup(project_name, project, "Entities", bisness_logic_group)
machine_entities_group = XcodeprojHelper::addGroup(project_name, project, "Machine", entities_group)
human_entities_group = XcodeprojHelper::addGroup(project_name, project, "Human", entities_group)
model_entities_group = XcodeprojHelper::addGroup(project_name, project, "Models", entities_group)

entities.each do |entity|


	# properties_array = Array.new
	# entity.attributes.each do |attribute|
	# 	properties = Hash.new
	# 	attribute.instance_variables.each {|x| properties[x[1..-1]] = attribute.instance_variable_get(x) }
	# 	properties_array.push(properties)
	# end

	# rel_array = Array.new
	# entity.relationships.each do |relationship|
	# 	rel = Hash.new
	# 	relationship.instance_variables.each {|x| rel[x[1..-1]] = relationship.instance_variable_get(x) }
	# 	rel_array.push(rel)
	# end

	machine_file_name = "_#{entity.name}.swift"
	human_file_name = "#{entity.name}.swift"
	model_file_name = "EN#{entity.name}.swift"

	machine_header = HeaderTemplate::generateHeader(project_name, machine_file_name)
	human_header = HeaderTemplate::generateHeader(project_name, human_file_name)
	model_header = HeaderTemplate::generateHeader(project_name, model_file_name)

	human_content =  EntityTemplate::generateHumanTemplate(entity, human_header, entities)
	machine_content = EntityTemplate::generateMachineTemplate(entity, machine_header, entities)
	model_content = EntityTemplate::generateModel(entity, model_header, entities)

	XcodeprojHelper::add_file(machine_file_name, machine_content, machine_entities_group, project_name, project)
	XcodeprojHelper::add_file(human_file_name, human_content, human_entities_group, project_name, project)
	XcodeprojHelper::add_file(model_file_name, model_content, model_entities_group, project_name, project)
end