require './Helpers/Helpers.rb'

class SerializerTemplate

	def self.generateSerializerTemplate(entity, header, entities)
		result = ""
		result += header
		result += "protocol I#{entity.name}Serializer: class {\n"
		result += "\t//MARK: - Interface\n"
		result += "\tfunc serialize(en#{entity.name}: EN#{entity.name}?, depth: Int) -> #{entity.name}?\n"
		result += "\tfunc serialize(en#{entity.name}s: [EN#{entity.name}], depth: Int) -> [#{entity.name}]\n"
		result += "\tfunc serialize(plain#{entity.name}: #{entity.name}?) -> EN#{entity.name}?\n"
		result += "\tfunc serialize(plain#{entity.name}s: [#{entity.name}]) -> [EN#{entity.name}]\n"

		inherited_attributes = Helpers::recursiveAttributes(entity)
		inherited_relationships = Helpers::recursiveRealtionships(entity)

		entity_names = inherited_relationships.map { |r| r.destinationEntity }.uniq
		if entity_names.length != 0 
			result += "\t//MARK: - Dependencies\n"
		end
		entity_names.each do |r|
			result += "\tvar #{r.lowercase_first}Serializer: I#{r.upcase_first}Serializer! { get set }\n"
		end
		result += "}\n\n"
		result += "final class #{entity.name}Serializer: I#{entity.name}Serializer {\n\n"
		result += "\t//MARK: - Dependencies\n"
		entity_names.each do |r|
			result += "\tvar #{r.lowercase_first}Serializer: I#{r.upcase_first}Serializer!\n"
		end
		result += "\n"
		result += "\tfunc serialize(en#{entity.name}: EN#{entity.name}?, depth: Int) -> #{entity.name}? {\n"
		result += "\n\t\tguard let l#{entity.name} = en#{entity.name} else { return nil }\n"
		result += "\t\tguard depth > 0 else { return nil }\n"
		result += "\t\tlet maxDepth: Int = min(MAX_SERIALIZATION_DEPTH, depth)\n\n"
		init_string = Array.new

		if inherited_attributes.length != 0 
			result += "\t\t//MARK: - Serializing attributes\n"
			inherited_attributes.each do |attr|
				init_string.push("#{attr.name}: #{attr.name}")
				if (attr.is_optional == "YES") && (attr.type == "Int" || attr.type == "Float" || attr.type == "Double" || attr.type == "Bool" || attr.type == "Int8" || attr.type == "Int16"|| attr.type == "Int32" || attr.type == "Int64")   
					result += "\t\tlet #{attr.name} = l#{entity.name}.#{attr.name}.value\n"
				else
					result += "\t\tlet #{attr.name} = l#{entity.name}.#{attr.name}\n"
				end
			end
		end
		result += "\n"
		if inherited_relationships.length != 0 
			result += "\t\t//MARK: - Serializing relationships\n"
			inherited_relationships.each do |rel|
				init_string.push("#{rel.name}: #{rel.name}")
				if rel.toMany == "NO"
					result += "\t\tlet #{rel.name} = self.#{rel.destinationEntity.lowercase_first}Serializer.serialize(en#{rel.destinationEntity}: l#{entity.name}.#{rel.name}, depth: maxDepth - 1)"
				else 
					result += "\t\tlet #{rel.name} = self.#{rel.destinationEntity.lowercase_first}Serializer.serialize(en#{rel.destinationEntity}s: Array(l#{entity.name}.#{rel.name}), depth: maxDepth - 1)"
				end
				if rel.is_optional == "NO"
					result += "!"
				end
				result += "\n"
			end
		end

		result += "\n"
		init_string = init_string.sort_by { |name| name }
		result += "\t\treturn #{entity.name}(#{init_string.join(", ")})\n"
		result += "\t}\n\n"

		result += "\tfunc serialize(en#{entity.name}s: [EN#{entity.name}], depth: Int) -> [#{entity.name}] {\n"
		result += "\n\t\tguard en#{entity.name}s.count != 0 else { return [] }\n"
		result += "\t\tvar serialized#{entity.name}s: [#{entity.name}] = []\n"
		result += "\t\tfor value in en#{entity.name}s {\n"
		result += "\t\t\tguard let entity = self.serialize(en#{entity.name}: value, depth: depth) else { continue }\n"
		result += "\t\t\tserialized#{entity.name}s.append(entity)\n"
		result += "\t\t}\n"
		result += "\t\treturn serialized#{entity.name}s\n"
		result += "\t}\n\n"

		result += "\tfunc serialize(plain#{entity.name}: #{entity.name}?) -> EN#{entity.name}? {\n"
		result += "\t\tguard let l#{entity.name} = plain#{entity.name} else { return nil }\n"
		result += "\n\t\tlet en#{entity.name}: EN#{entity.name} = EN#{entity.name}()\n\n"
		if inherited_attributes.length > 0 
			result += "\t\t//MARK: - Attributes\n"
		end
		inherited_attributes.each do |attr|
			if (attr.is_optional == "YES") && (attr.type == "Int" || attr.type == "Float" || attr.type == "Double" || attr.type == "Bool" || attr.type == "Int8" || attr.type == "Int16"|| attr.type == "Int32" || attr.type == "Int64")   
				result += "\t\ten#{entity.name}.#{attr.name}.value = l#{entity.name}.#{attr.name}\n"
			else
				result += "\t\ten#{entity.name}.#{attr.name} = l#{entity.name}.#{attr.name}\n"
			end
		end

		entities = entities.sort { |x, y| x.name <=> y.name }

		one_to_one_relationships_mark = ""
		one_to_many_relationships_mark = ""
		many_to_many_relationships_mark = ""

		entity.relationships.each do |rel|

				search_entity = entities.find { |e| e.name == rel.destinationEntity }
				relationship_inversed = search_entity.relationships.find { |r| r.destinationEntity == entity.name }

				if rel.toMany == "NO" && relationship_inversed.toMany == "NO"
					if entity.name > search_entity.name
						one_to_one_relationships_mark += "\t\tlet _en#{rel.destinationEntity} = self.#{rel.destinationEntity.lowercase_first}Serializer.serialize(plain#{rel.destinationEntity}: l#{entity.name}.#{rel.name})\n"
						one_to_one_relationships_mark += "\t\ten#{entity.name}.#{rel.name} = _en#{rel.destinationEntity}\n"
					else
						one_to_one_relationships_mark += "\t\tlet _#{rel.name} = self.#{rel.destinationEntity.lowercase_first}Serializer.serialize(plain#{rel.destinationEntity}: l#{entity.name}.#{rel.name})\n"
						if rel.is_optional == "YES"
							one_to_one_relationships_mark += "\t\t_#{rel.name}?.#{relationship_inversed.name} = en#{entity.name}\n"
						else	
							one_to_one_relationships_mark += "\t\t_#{rel.name}?.#{relationship_inversed.name} = en#{entity.name}\n"
						end
					end
				elsif rel.toMany == "YES" && relationship_inversed.toMany == "NO"
					if entity.name > search_entity.name
						if rel.is_optional == "YES"
							one_to_many_relationships_mark += "\t\tlet _#{rel.name} = self.#{rel.destinationEntity.lowercase_first}Serializer.serialize(plain#{rel.destinationEntity}s: l#{entity.name}.#{rel.name} ?? [])\n"
						else 
							one_to_many_relationships_mark += "\t\tlet _#{rel.name} = self.#{rel.destinationEntity.lowercase_first}Serializer.serialize(plain#{rel.destinationEntity}s: l#{entity.name}.#{rel.name})\n"
						end
						one_to_many_relationships_mark += "\t\t_#{rel.name}.forEach { en#{entity.name}.#{rel.name}.append($0) }\n"
					else
						if rel.is_optional == "YES"
							one_to_many_relationships_mark += "\t\tlet _#{rel.name} = self.#{rel.destinationEntity.lowercase_first}Serializer.serialize(plain#{rel.destinationEntity}s: l#{entity.name}.#{rel.name} ?? [])\n"
						else 
							one_to_many_relationships_mark += "\t\tlet _#{rel.name} = self.#{rel.destinationEntity.lowercase_first}Serializer.serialize(plain#{rel.destinationEntity}s: l#{entity.name}.#{rel.name})\n"
						end
						one_to_many_relationships_mark += "\t\t_#{rel.name}.forEach { $0.#{relationship_inversed.name} = en#{entity.name} }\n"
					end
				elsif rel.toMany == "NO" && relationship_inversed.toMany == "YES"
					if entity.name > search_entity.name
						one_to_one_relationships_mark += "\t\tlet _en#{rel.destinationEntity} = self.#{rel.destinationEntity.lowercase_first}Serializer.serialize(plain#{rel.destinationEntity}: l#{entity.name}.#{rel.name})\n"
						one_to_one_relationships_mark += "\t\ten#{entity.name}.#{rel.name} = _en#{rel.destinationEntity}\n"
					else
						one_to_one_relationships_mark += "\t\tlet _#{rel.name} = self.#{rel.destinationEntity.lowercase_first}Serializer.serialize(plain#{rel.destinationEntity}: l#{entity.name}.#{rel.name})\n"
						if rel.is_optional == "YES"
							one_to_one_relationships_mark += "\t\t_#{rel.name}?.#{relationship_inversed.name}.append(en#{entity.name})\n"
						else	
							one_to_one_relationships_mark += "\t\t_#{rel.name}?.#{relationship_inversed.name}.append(en#{entity.name})\n"
						end	
					end
				elsif rel.toMany == "YES" && relationship_inversed.toMany == "YES"
					if entity.name > search_entity.name
						if rel.is_optional == "YES"
							many_to_many_relationships_mark += "\t\tlet _#{rel.name} = self.#{rel.destinationEntity.lowercase_first}Serializer.serialize(plain#{rel.destinationEntity}s: l#{entity.name}.#{rel.name} ?? [])\n"
						else 
							many_to_many_relationships_mark += "\t\tlet _#{rel.name} = self.#{rel.destinationEntity.lowercase_first}Serializer.serialize(plain#{rel.destinationEntity}s: l#{entity.name}.#{rel.name})\n"
						end
						many_to_many_relationships_mark += "\t\t_#{rel.name}.forEach { en#{entity.name}.#{rel.name}.append($0) }\n"
					else
						if rel.is_optional == "YES"
							many_to_many_relationships_mark += "\t\tlet _#{rel.name} = self.#{rel.destinationEntity.lowercase_first}Serializer.serialize(plain#{rel.destinationEntity}s: l#{entity.name}.#{rel.name} ?? [])\n"
						else 
							many_to_many_relationships_mark += "\t\tlet _#{rel.name} = self.#{rel.destinationEntity.lowercase_first}Serializer.serialize(plain#{rel.destinationEntity}s: l#{entity.name}.#{rel.name})\n"
						end
						many_to_many_relationships_mark += "\t\t_#{rel.name}.forEach { $0.#{relationship_inversed.name}.append(en#{entity.name}) }\n"
					end
				end
		end

		result += "\n"
		if one_to_one_relationships_mark != ""
			result += "\t\t//MARK: - One-to-one relationships\n"
			result += "#{one_to_one_relationships_mark}\n"
		end
		if one_to_many_relationships_mark != ""
			result += "\t\t//MARK: - One-to-many relationships\n"
			result += "#{one_to_many_relationships_mark}\n"
		end
		if many_to_many_relationships_mark != ""
			result += "\t\t//MARK: - Many-to-many relationships\n"
			result += "#{many_to_many_relationships_mark}\n"
		end

		result += "\t\treturn en#{entity.name}\n"
		result += "\t}\n\n"

		result += "\tfunc serialize(plain#{entity.name}s: [#{entity.name}]) -> [EN#{entity.name}] {\n"
		result += "\t\tguard plain#{entity.name}s.count > 0 else { return [] }\n"
		result += "\t\tvar serialized#{entity.name}s: [EN#{entity.name}] = []\n"
		result += "\t\tfor value in plain#{entity.name}s {\n"
		result += "\t\t\tguard let entity = self.serialize(plain#{entity.name}: value) else { continue }\n"
		result += "\t\t\tserialized#{entity.name}s.append(entity)\n"
		result += "\t\t}\n"
		result += "\t\treturn serialized#{entity.name}s\n"
		result += "\t}\n"

		result += "}\n\n"

		return result
	end

end
