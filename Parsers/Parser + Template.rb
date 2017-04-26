require './Helpers/Helpers.rb'

class ParserTemplate

	def self.generateParserTemplate(entity, header, entities)
		result = ""
		result += header
		
		result += "protocol I#{entity.name}Parser: class {\n"
		result += "\tfunc serialize(json: Dictionary<String, Any?>) throws -> EN#{entity.name}\n"
		result += "\tfunc serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [EN#{entity.name}]\n"
		entity_names = entity.relationships.map { |r| r.destinationEntity }.uniq
		entity_names.each do |r|
			result += "\tvar #{r.lowercase_first}Parser: I#{r.upcase_first}Parser! { get set }\n"
		end
		result += "}\n\n"
		result += "final class #{entity.name}Parser: I#{entity.name}Parser {\n\n"
		result += "\t//MARK: - Dependencies\n"
		entity_names.each do |r|
			result += "\tvar #{r.lowercase_first}Parser: I#{r.upcase_first}Parser!\n"
		end
		result += "\n"
		result += "\tfunc serialize(json: Dictionary<String, Any?>) throws -> EN#{entity.name} {\n\n"
		result += "\t\tlet en#{entity.name}: EN#{entity.name} = EN#{entity.name}()\n"
		if entity.attributes.length != 0 
			result += "\n\t\t//MARK: - Parsing attributes\n"
		end
		entity.attributes.each do |attr|
			if (attr.is_optional == "YES") && (attr.type == "Int" || attr.type == "Float" || attr.type == "Double" || attr.type == "Bool" || attr.type == "Int8" || attr.type == "Int16"|| attr.type == "Int32" || attr.type == "Int64")   
				result += "\t\ten#{entity.name}.#{attr.name}.value = try json.value(by: \"#{attr.name}\")\n"
			else
				result += "\t\ten#{entity.name}.#{attr.name} = try json.value(by: \"#{attr.name}\")\n"
			end
		end

		one_to_one_relationships_mark = ""
		one_to_many_relationships_mark = ""
		many_to_many_relationships_mark = ""

		entities = entities.sort { |x, y| x.name <=> y.name }

		entity.relationships.each do |rel|
				
				search_entity = entities.find { |e| e.name == rel.destinationEntity }
				relationship_inversed = search_entity.relationships.find { |rel| rel.destinationEntity == entity.name }

				if rel.toMany == "NO" && relationship_inversed.toMany == "NO"
					if entity.name > search_entity.name
						one_to_one_relationships_mark += "\t\ten#{entity.name}.#{rel.name} = try self.#{rel.destinationEntity.lowercase_first}Parser.serialize(json: json.value(by: \"#{rel.name}\"))\n"
					else
						one_to_one_relationships_mark += "\t\tlet _#{rel.name} = try self.#{rel.destinationEntity.lowercase_first}Parser.serialize(json: json.value(by: \"#{rel.name}\"))\n"
						one_to_one_relationships_mark += "\t\t_#{rel.name}.#{relationship_inversed.name} = en#{entity.name}\n"
					end
				elsif rel.toMany == "YES" && relationship_inversed.toMany == "NO"
					if entity.name > search_entity.name
						one_to_many_relationships_mark += "\t\tlet _#{rel.name} = try self.#{rel.destinationEntity.lowercase_first}Parser.serialize(jsonArray: json.value(by: \"#{rel.name}\"))\n"
						one_to_many_relationships_mark += "\t\t_#{rel.name}.forEach { en#{entity.name}.#{rel.name}.append($0) }\n"
					else
						one_to_many_relationships_mark += "\t\tlet _#{rel.name} = try self.#{rel.destinationEntity.lowercase_first}Parser.serialize(jsonArray: json.value(by: \"#{rel.name}\"))\n"
						one_to_many_relationships_mark += "\t\t_#{rel.name}.forEach { $0.#{relationship_inversed.name} = en#{entity.name} }\n"
					end
				elsif rel.toMany == "NO" && relationship_inversed.toMany == "YES"
					if entity.name > search_entity.name
						one_to_one_relationships_mark += "\t\ten#{entity.name}.#{rel.name} = try self.#{rel.destinationEntity.lowercase_first}Parser.serialize(json: json.value(by: \"#{rel.name}\"))\n"
					else
						one_to_one_relationships_mark += "\t\tlet _#{rel.name} = try self.#{rel.destinationEntity.lowercase_first}Parser.serialize(json: json.value(by: \"#{rel.name}\"))\n"
						one_to_one_relationships_mark += "\t\t_#{rel.name}.#{relationship_inversed.name}.append(en#{entity.name})\n"
					end
				elsif rel.toMany == "YES" && relationship_inversed.toMany == "YES"
					if entity.name > search_entity.name
						many_to_many_relationships_mark += "\t\tlet _#{rel.name} = try self.#{rel.destinationEntity.lowercase_first}Parser.serialize(jsonArray: json.value(by: \"#{rel.name}\"))\n"
						many_to_many_relationships_mark += "\t\t_#{rel.name}.forEach { en#{entity.name}.#{rel.name}.append($0) }\n"
					else
						many_to_many_relationships_mark += "\t\tlet _#{rel.name} = try self.#{rel.destinationEntity.lowercase_first}Parser.serialize(jsonArray: json.value(by: \"#{rel.name}\"))\n"
						many_to_many_relationships_mark += "\t\t_#{rel.name}.forEach { $0.#{relationship_inversed.name}.append(en#{entity.name}) }\n"
					end
				end
			end

		if one_to_one_relationships_mark != ""
			result += "\n\t\t//MARK: - One-to-one relationships parsing\n"
			result += one_to_one_relationships_mark
		end
		if one_to_many_relationships_mark != ""
			result += "\n\t\t//MARK: - One-to-many relationships parsing\n"
			result += one_to_many_relationships_mark
		end
		if many_to_many_relationships_mark != ""
			result += "\n\t\t//MARK: - Many-to-many relationships parsing\n"
			result += many_to_many_relationships_mark
		end
		result += "\n\t\treturn en#{entity.name}\n"
		result += "\t}\n\n"

		result += "\tfunc serialize(jsonArray: [Dictionary<String, Any?>]) throws -> [EN#{entity.name}] {\n"
		result += "\t\tguard jsonArray.count > 0 else { return [] }\n"
		result += "\t\tvar en#{entity.name}s: [EN#{entity.name}] = []\n"
		result += "\t\tfor json in jsonArray {\n"
		result += "\t\t\tlet en#{entity.name}: EN#{entity.name} = try self.serialize(json: json)\n"
		result += "\t\t\ten#{entity.name}s.append(en#{entity.name})\n"
		result += "\t\t}\n"
		result += "\t\treturn en#{entity.name}s\n"
		result += "\t}\n"
		result += "\n}"
		return result
	end

end