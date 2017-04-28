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
require './Transport/Transport + Template.rb'
require './Services/Service + Template.rb'
require './Parsers/Parser + Template.rb'
require './Serializers/Serializer + Template.rb'
require './Storage/Storage + Template.rb'

data_model_path = ARGV[0]

project_paths = Dir["*.xcodeproj"] # PROJECT.xcodeproj

if project_paths.length > 1
	puts "There are more than 1 .xcodeproj files. Abort"
	exit 1
end

project_path = project_paths.first

project = XcodeprojHelper::openProject(project_path)
project_name = project_paths.first.split("/").last.split(".").first

entities = ModelReader::readEntities(data_model_path)

bisness_logic_group = XcodeprojHelper::addGroup(project_name, project, "Business Logic")

transport_group = XcodeprojHelper::addGroup(project_name, project, "Transport layer", bisness_logic_group)
entities_group = XcodeprojHelper::addGroup(project_name, project, "Data layer", bisness_logic_group)
service_group = XcodeprojHelper::addGroup(project_name, project, "Service layer", bisness_logic_group)
parser_group = XcodeprojHelper::addGroup(project_name, project, "Parsers layer", bisness_logic_group)
serialization_group = XcodeprojHelper::addGroup(project_name, project, "Serializers layer", bisness_logic_group)
storage_entities_group = XcodeprojHelper::addGroup(project_name, project, "Persistence layer", bisness_logic_group)

storage_group = XcodeprojHelper::addGroup(project_name, project, "Storage", storage_entities_group)

poso_group = XcodeprojHelper::addGroup(project_name, project, "POSO", entities_group)
machine_entities_group = XcodeprojHelper::addGroup(project_name, project, "Machine", poso_group)
human_entities_group = XcodeprojHelper::addGroup(project_name, project, "Human", poso_group)
model_entities_group = XcodeprojHelper::addGroup(project_name, project, "Database models", entities_group)

storage_file_name = "Storage.swift"
storage_file_header = HeaderTemplate::generateHeader(project_name, storage_file_name)
storage_file_content = StorageTemplate::generateStorageTemplate(storage_file_header)
XcodeprojHelper::add_file(storage_file_name, storage_file_content, storage_group, project)

iterator = 0
entities.each do |entity|

	machine_file_name = "_#{entity.name}.swift"
	human_file_name = "#{entity.name}.swift"
	model_file_name = "EN#{entity.name}.swift"
	transport_file_name = "#{entity.name}Transport.swift"
	service_file_name = "#{entity.name}Service.swift"
	parser_file_name = "#{entity.name}Parser.swift"
	serializer_file_name = "#{entity.name}Serializer.swift"
	storage_entities_file_name = "#{entity.name}Storage.swift"

	machine_header = HeaderTemplate::generateHeader(project_name, machine_file_name)
	human_header = HeaderTemplate::generateHeader(project_name, human_file_name)
	model_header = HeaderTemplate::generateHeader(project_name, model_file_name)
	transport_header = HeaderTemplate::generateHeader(project_name, transport_file_name)
	service_header = HeaderTemplate::generateHeader(project_name, service_file_name)
	parser_header = HeaderTemplate::generateHeader(project_name, parser_file_name)
	serializer_header = HeaderTemplate::generateHeader(project_name, serializer_file_name)
	storage_entities_header = HeaderTemplate::generateHeader(project_name, storage_entities_file_name)

	human_content =  EntityTemplate::generateHumanTemplate(entity, human_header, entities)
	machine_content = EntityTemplate::generateMachineTemplate(entity, machine_header, entities)
	model_content = EntityTemplate::generateModel(entity, model_header, entities)
	transport_content = TransportTemplate::generateTransportTemplate(entity, transport_header)
	service_content = ServiceTemplate::generateServiceTemplate(entity, service_header)
	parser_content = ParserTemplate::generateParserTemplate(entity, parser_header, entities)
	serializer_content = SerializerTemplate::generateSerializerTemplate(entity, serializer_header, entities)
	storage_entities_content = StorageTemplate::generateStorageEntitiesTemplate(entity, storage_entities_header)

	XcodeprojHelper::add_file(machine_file_name, machine_content, machine_entities_group, project, true)
	XcodeprojHelper::add_file(human_file_name, human_content, human_entities_group, project)
	XcodeprojHelper::add_file(model_file_name, model_content, model_entities_group, project)
	XcodeprojHelper::add_file(transport_file_name, transport_content, transport_group, project)
	XcodeprojHelper::add_file(service_file_name, service_content, service_group, project)
	XcodeprojHelper::add_file(parser_file_name, parser_content, parser_group, project)
	XcodeprojHelper::add_file(serializer_file_name, serializer_content, serialization_group, project)
	XcodeprojHelper::add_file(storage_entities_file_name, storage_entities_content, storage_entities_group, project)

	iterator += 1 
	print "Generating files for entities - #{(100.0 * (iterator.to_f/entities.length.to_f)).to_i} %"
	if iterator != entities.length
		print "\r"
	else 
		print "\n"
	end
end

puts "Done!"