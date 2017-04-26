require './Helpers/Helpers.rb'

class SerializerTemplate

	def self.generateSerializerTemplate(entity, header, entities)
		result = ""
		result += header
		result += "protocol I#{entity.name}Serializer: class {\n"
		result += "\tfunc serialize(en#{entity.name}: EN#{entity.name}?, depth: Int) -> #{entity.name}?\n"
		result += "\tfunc serialize(en#{entity.name}s: [EN#{entity.name}], depth: Int) -> [#{entity.name}]\n"

		inherited_attributes = Helpers::recursiveAttributes(entity)
		inherited_relationships = Helpers::recursiveRealtionships(entity)

		entity_names = inherited_relationships.map { |r| r.destinationEntity }.uniq
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
		result += "\t}\n"
		result += "}\n"
		return result
	end

end

# func serialize(json: JSON) throws -> ENCase {
#         guard let id: String = json[Case.Keys.id].string else { throw CaseParserError.FieldCannotBeNil(Case.Keys.id) }
#         guard let caseNumber: Int = json[Case.Keys.caseNumber].int else { throw CaseParserError.FieldCannotBeNil(Case.Keys.caseNumber) }
#         //MARK: - Main
#         let enCase = ENCase()
#         enCase.id = id
#         enCase.caseNumber = caseNumber
#         enCase.beganAt = json[Case.Keys.beganAt].stringValue.ISO8601Date
#         enCase.complaint = try? self.complaintParser.serialize(json: json[Case.Keys.complaint])
#         enCase.destinationHospital = try? self.hospitalParser.serialize(json: json[Case.Keys.destinationHospital])
#         enCase.emsAgency = try? self.agencyParser.serialize(json: json[Case.Keys.agency])
#         enCase.user = try? self.userParser.serialize(json: json[Case.Keys.user])
#         enCase.truck = try? self.truckParser.serialize(json: json[Case.Keys.truck])
#         enCase.lastLocation = try? self.locationParser.serialize(json: json[Case.Keys.lastLocation])
#         if let uploads = json[Case.Keys.uploads].array {
#             for uploadJSON in uploads {
#                 let upload: ENUpload = try self.uploadParser.serialize(json: uploadJSON)
#                 enCase.uploads.append(upload)
#             }
#         }
#         if let messages = json[Case.Keys.messages].array {
#             for messageJSON in messages {
#                 let message: ENMessage = try self.messageParser.serialize(json: messageJSON)
#                 message.twCase = enCase
#             }
#         }
#         return enCase
#     }