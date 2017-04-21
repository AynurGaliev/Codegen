require './Type.rb'

class ModelReader 

	ENTITY_KEY = "entity"
	ATTRIBUTE_KEY = "attribute"
	RELATIONSHIP_KEY = "relationship"

	def self.path_to_model_xml(path)
		extension = File.extname(path).strip.downcase[1..-1] # Trying to get extension

		if extension != "xcdatamodeld"
			puts "File have wrong (#{extension}) extension. Abort"
			exit 1
		end

		data_model = Dir["#{path}/*.xcdatamodel"] # Trying to get .xcdatamodel file

		if data_model == nil 
			puts "File have not .xcdatamodel file. Abort"
			exit 1
		end

		if data_model.length > 1 
			puts ".xcdatamodeld have more than one file. Abort"
		end

		contents_path = Dir["#{data_model.first}/contents"]		# Trying to get contents

		if contents_path == nil 
			puts "File have not contents file. Abort"
			exit 1
		end

		if contents_path.length > 1 
			puts ".xcdatamodel have more than one file. Abort"
		end

		contents_path.first
	end
	
	def self.readEntities(model_file_path)

		path_to_model = path_to_model_xml(model_file_path)

		data = File.open(path_to_model) { |f| Nokogiri::XML(f) }

		entities = Array.new
		data.xpath("//#{ENTITY_KEY}").each do |entityRoot|

			attributes = Array.new
			entityRoot.xpath("#{ATTRIBUTE_KEY}").each do |attributeRoot|
				attribute_type = nil
				attributeRoot.xpath('userInfo').xpath('entry').each do |info|
					if info[:key] == "attributeValueClassName"
						attribute_type = info[:value]
					end
				end
				if attribute_type == nil 
					attribute_type = Type::convertToSwiftType(attributeRoot[:attributeType])
				end
				is_optional = attributeRoot[:optional]
				if is_optional == nil 
					is_optional = "NO"
				end
				attributeName = attributeRoot[:name]
				attribute = Attribute.new(attributeName, attribute_type, is_optional)
				attributes.push(attribute)
			end

			relationships = Array.new
			entityRoot.xpath("#{RELATIONSHIP_KEY}").each do |relationshipRoot|
				relationshipName = relationshipRoot[:name]
				is_optional = relationshipRoot[:optional]
				if is_optional == nil 
					is_optional = "NO"
				end
				toMany = relationshipRoot[:toMany]
				if toMany == nil 
					toMany = "NO"
				end
				deletionRule = relationshipRoot[:deletionRule]
				destinationEntity = relationshipRoot[:destinationEntity]
				inverseName = relationshipRoot[:inverseName]
				inverseEntity = relationshipRoot[:inverseEntity]

				relationship = Relationship.new(relationshipName, inverseName, deletionRule, destinationEntity, toMany, is_optional, inverseEntity)
				relationships.push(relationship)
			end

			entityName = entityRoot[:name]
			parentEntity = entityRoot[:parentEntity]
			new_entity = Entity.new(entityName, attributes, relationships)
			new_entity.parent = parentEntity
			entities.push(new_entity)

		end

		entities.each do |e|
			if e.parent != nil 
				entities.each do |search_entity|
					if search_entity.name == e.parent
						search_entity.children.push(e)
						e.parent = search_entity
					end
				end
			end
		end

		entities
	end 
end