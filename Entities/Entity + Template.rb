class EntityTemplate

	def self.generateMachineTemplate(entity, header, entities)

		result = header

		result += "class _#{entity.name}"
		if entity.parent != nil 
			result += ": _#{entity.parent.name} {\n"
		else
			result += " {\n"
		end

		result += "\n"
		
		init_string = Array.new
		constructor_string = Array.new

		entity.attributes.each do |attr|
			constructor_string.push("\t\tself.#{attr.name} = #{attr.name}") 
			temp_string = "#{attr.name}: #{attr.type}"
			if attr.is_optional == "YES"
				temp_string += "?"
			end
			result += "\tlet #{temp_string}\n"
			init_string.push(temp_string) 
		end

		entity.relationships.each do |rel|
			constructor_string.push("\t\tself.#{rel.name} = #{rel.name}") 
			relationship_string = ""
			if rel.toMany == "YES"
				relationship_string = "[#{rel.destinationEntity}]"
			else
				relationship_string = "#{rel.destinationEntity}"
			end
			if rel.is_optional == "YES"
				relationship_string += "?"
			end
			temp_string = "#{rel.name}: #{relationship_string}"
			result += "\tlet #{temp_string}\n"
			init_string.push(temp_string) 
		end

		result += "\n\t"

		super_init_string = Array.new
		if entity.parent != nil 
			
			all_attributes = self.recursiveAttributes(entity)
			all_relationships = self.recursiveRealtionships(entity)

			inherited_attributes = all_attributes
			entity.attributes.each do |a| 
				found_attr = inherited_attributes.find {|x|  x.name == a.name }
				if found_attr != nil
					inherited_attributes.delete(found_attr)
				end
			end

			inherited_relationships = all_relationships
			entity.relationships.each do |r|
				found_rel = inherited_relationships.find{|x| x.name == r.name }
				if found_rel != nil
					inherited_relationships.delete(found_rel)
				end
			end

			all_attributes.each do |attr|
				attributes_string = "#{attr.type}"
				if attr.is_optional == "YES"
					attributes_string += "?"
				end
				init_string.push("#{attr.name}: #{attributes_string}")
			end

			all_relationships.each do |rel|
				relationship_string = ""
				if rel.toMany == "YES"
					relationship_string = "[#{rel.destinationEntity}]"
				else
					relationship_string = "#{rel.destinationEntity}"
				end
				if rel.is_optional == "YES"
					relationship_string += "?"
				end
				init_string.push("#{rel.name}: #{relationship_string}")
			end

			inherited_attributes.each do |attr|
				super_init_string.push("#{attr.name}: #{attr.name}")
			end

			inherited_relationships.each do |rel|
				super_init_string.push("#{rel.name}: #{rel.name}")
			end

		end

		result += "init(#{init_string.sort_by {|a| a }.join(", ")}) {\n"

		result += "#{constructor_string.sort_by {|a| a }.join("\n")}\n"
		if entity.parent != nil
			result += "\t\tsuper.init(#{super_init_string.sort_by {|a| a }.join(", ")})\n"
		end
		result += "\t}\n\n"

		result += "\tenum Keys {\n"
		entity.attributes.each do |attr|
			result += "\t\tstatic let #{attr.name}: String = \"#{attr.name}\"\n"
		end

		entity.relationships.each do |rel|
			result += "\t\tstatic let #{rel.name}: String = \"#{rel.name}\"\n"
		end
		result += "\t}\n"

		result += "}\n\n"

		result += "func ==(lhs: #{entity.name}, rhs: #{entity.name}) -> Bool {\n"
		temp_array = Array.new
		entity.attributes.each do |attr|
			temp_array.push("lhs.#{attr.name} == rhs.#{attr.name}") 
		end

		entity.relationships.each do |rel|
			temp_array.push("lhs.#{rel.name} == rhs.#{rel.name}") 
		end

		result += "\treturn #{temp_array.join(" && ")} \n}\n\n"

		result += "func ==(lhs: #{entity.name}?, rhs: #{entity.name}?) -> Bool {\n"
		result += "\tguard lhs != nil || rhs != nil else { return true }\n"
		result += "\tif (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }\n"
		result += "\treturn lhs! == rhs!\n"
		result += "}\n\n"

		result += "func ==(lhs: [#{entity.name}]?, rhs: [#{entity.name}]?) -> Bool {\n"
		result += "\tguard lhs != nil || rhs != nil else { return true }\n"
		result += "\tif (lhs != nil && rhs == nil) && (lhs == nil && rhs != nil) { return false }\n"
		result += "\treturn lhs! == rhs!\n"
		result += "}\n"

		result

	end

	def self.generateHumanTemplate(entity, header, entities)
		result = header
		result += "final class #{entity.name}: _#{entity.name} {\n\t//Custom code goes here..\n}\n"
		return result
	end

	def self.generateModel(entity, header, entities)
		result = header
		result += "import RealmSwift\n\n"
		if entity.children.length == 0
			result += "final "
		end
		result += "class EN#{entity.name}"
		if entity.parent != nil 
			result += ": EN#{entity.parent.name} {\n"
		else 
			result += ": RealmSwift.Object {\n"
		end 
		result += "\n"

		if entity.attributes.length != 0
			result += "\t//MARK: - Attributes\n"
		end

		entity.attributes.each do |attr|
			temp_string = ""
			if attr.is_optional == "YES"
				if attr.type == "Int" || attr.type == "Float" || attr.type == "Double" || attr.type == "Bool" || attr.type == "Int8" || attr.type == "Int16"|| attr.type == "Int32" || attr.type == "Int64"   
					temp_string += "let #{attr.name} = RealmOptional<#{attr.type}>()"
				else
					temp_string += "dynamic var #{attr.name}: #{attr.type}?"
				end
			else 
				temp_string += "dynamic var #{attr.name}: #{attr.type} = #{Type::defaultValue(attr.type)}"
			end
			result += "\t#{temp_string}\n"
		end

		result += "\n"

		entities = entities.sort { |x, y| x.name <=> y.name }

		if entity.relationships.length != 0

			one_to_one_relationships_mark = ""
			one_to_many_relationships_mark = ""
			many_to_many_relationships_mark = ""

			entity.relationships.each do |rel|
				
				search_entity = entities.find { |e| e.name == rel.destinationEntity }
				relationship_inversed = search_entity.relationships.find { |rel| rel.destinationEntity == entity.name }

				if rel.toMany == "NO" && relationship_inversed.toMany == "NO"
					if entity.name > search_entity.name
						one_to_one_relationships_mark += "\tdynamic var #{rel.name}: EN#{rel.destinationEntity}?\n"
					else
						one_to_one_relationships_mark += "\tprivate let #{rel.name}s = LinkingObjects(fromType: EN#{search_entity.name}.self, property: \"#{relationship_inversed.name}\")\n"
						one_to_one_relationships_mark += "\tvar #{rel.name}: EN#{rel.destinationEntity}? {\n\t\treturn self.#{rel.name}s.first\n\t}\n"
					end
				elsif rel.toMany == "YES" && relationship_inversed.toMany == "NO"
					if entity.name > search_entity.name
						one_to_many_relationships_mark += "\tlet #{rel.name} = List<EN#{rel.destinationEntity}>()\n"
					else
						one_to_many_relationships_mark += "\tlet #{rel.name} =  LinkingObjects(fromType: EN#{search_entity.name}.self, property: \"#{relationship_inversed.name}\")\n"
					end
				elsif rel.toMany == "NO" && relationship_inversed.toMany == "YES"
					if entity.name > search_entity.name
						one_to_one_relationships_mark += "\tdynamic var #{rel.name}: EN#{rel.destinationEntity}?\n"
					else
						one_to_one_relationships_mark += "\tprivate let #{rel.name}s = LinkingObjects(fromType: EN#{search_entity.name}.self, property: \"#{relationship_inversed.name}\")\n"
						one_to_one_relationships_mark += "\tvar #{rel.name}: EN#{rel.destinationEntity}? {\n\t\treturn self.#{rel.name}s.first\n\t}\n"	
					end
				elsif rel.toMany == "YES" && relationship_inversed.toMany == "YES"
					if entity.name > search_entity.name
						many_to_many_relationships_mark += "\tlet #{rel.name} = List<EN#{rel.destinationEntity}>()\n"
					else
						many_to_many_relationships_mark += "\tlet #{rel.name} =  LinkingObjects(fromType: EN#{search_entity.name}.self, property: \"#{relationship_inversed.name}\")\n"
					end
				end
			end

			if one_to_one_relationships_mark != ""
				result += "\t//MARK: - One-to-one relationships\n"
				result += "#{one_to_one_relationships_mark}\n"
			end
			if one_to_many_relationships_mark != ""
				result += "\t//MARK: - One-to-many relationships\n"
				result += "#{one_to_many_relationships_mark}\n"
			end
			if many_to_many_relationships_mark != ""
				result += "\t//MARK: - Many-to-many relationships\n"
				result += "#{many_to_many_relationships_mark}\n"
			end
		end

		result += "}\n"
		return result
	end	

	#Helpers

	def self.recursiveAttributes(entity)
		attributes = Array.new
		entity.attributes.each do |a|
			attributes.push(a)
		end
		if entity.parent != nil
			inherited_attributes = self.recursiveAttributes(entity.parent)
			inherited_attributes.each do |a|
				attributes.push(a)
			end
		end
		return attributes.sort_by { |attr| attr.name }
	end

	def self.recursiveRealtionships(entity)
		relationships = Array.new
		entity.relationships.each do |r|
			relationships.push(r)
		end
		if entity.parent != nil
			inherited_relationships = self.recursiveRealtionships(entity.parent)
			inherited_relationships.each do |a|
				relationships.push(a)
			end
		end
		return relationships.sort_by { |rel| rel.name }
	end

end