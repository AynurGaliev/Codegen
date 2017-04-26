require './Helpers/Helpers.rb'

class ParserTemplate

	def self.generateParserTemplate(entity, header)
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
		entity.relationships.each do |r|
			if r.toMany == "NO"
				one_to_one_relationships_mark += "\t\ten#{entity.name}.#{r.name} = try self.#{r.destinationEntity.lowercase_first}Parser.serialize(json: json.value(by: \"#{r.name}\"))\n"
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

# import SwiftyJSON

# protocol ICaseParser: class {
#     func serialize(json: JSON) throws -> ENCase
#     func deserialize(enCase: ENCase) -> JSON
#     func inject(complaintParser: IComplaintParser!)
#     func inject(hospitalParser: IHospitalParser!)
#     func inject(agencyParser: IAgencyParser!)
#     func inject(userParser: IUserParser!)
#     func inject(truckParser: ITruckParser!)
#     func inject(locationParser: ILocationParser!)
#     func inject(uploadParser: IUploadParser!)
#     func inject(messageParser: IMessageParser!)
# }

# enum CaseParserError: Error {
#     case FieldCannotBeNil(String)
# }

# final class CaseParser: ICaseParser {

#     private var complaintParser : IComplaintParser!
#     private var hospitalParser  : IHospitalParser!
#     private var agencyParser    : IAgencyParser!
#     private var userParser      : IUserParser!
#     private var truckParser     : ITruckParser!
#     private var locationParser  : ILocationParser!
#     private var uploadParser    : IUploadParser!
#     private var messageParser   : IMessageParser!
    
#     func inject(complaintParser: IComplaintParser!) {
#         self.complaintParser = complaintParser
#     }
    
#     func inject(hospitalParser: IHospitalParser!) {
#         self.hospitalParser = hospitalParser
#     }
    
#     func inject(agencyParser: IAgencyParser!) {
#         self.agencyParser = agencyParser
#     }
    
#     func inject(userParser: IUserParser!) {
#         self.userParser = userParser
#     }
    
#     func inject(truckParser: ITruckParser!) {
#         self.truckParser = truckParser
#     }
    
#     func inject(locationParser: ILocationParser!) {
#         self.locationParser = locationParser
#     }
    
#     func inject(uploadParser: IUploadParser!) {
#         self.uploadParser = uploadParser
#     }
    
#     func inject(messageParser: IMessageParser!) {
#         self.messageParser = messageParser
#     }
    
#     func serialize(json: JSON) throws -> ENCase {
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
    
#     func deserialize(enCase: ENCase) -> JSON {
#         var json: [String : Any?] = [:]
#         json[Case.Keys.id] = enCase.id
#         json[Case.Keys.caseNumber] = enCase.caseNumber
#         json[Case.Keys.beganAt] = enCase.beganAt?.ISO8601String
#         if let lComplaint = enCase.complaint {
#             json[Case.Keys.complaint] = self.complaintParser.deserialize(complaint: lComplaint)
#         } else {
#             json[Case.Keys.complaint] = nil
#         }
#         if let lHospital = enCase.destinationHospital {
#             json[Case.Keys.destinationHospital] = self.hospitalParser.deserialize(hospital: lHospital)
#         } else {
#             json[Case.Keys.destinationHospital] = nil
#         }
#         if let lAgency = enCase.emsAgency {
#             json[Case.Keys.agency] = self.agencyParser.deserialize(agency: lAgency)
#         } else {
#             json[Case.Keys.agency] = nil
#         }
#         if let lUser = enCase.user {
#             json[Case.Keys.user] = self.userParser.deserialize(user: lUser)
#         } else {
#             json[Case.Keys.user] = nil
#         }
#         if let lTruck = enCase.truck {
#             json[Case.Keys.truck] = self.truckParser.deserialize(truck: lTruck)
#         } else {
#             json[Case.Keys.truck] = nil
#         }
#         if let lLocation = enCase.lastLocation {
#             json[Case.Keys.lastLocation] = self.locationParser.deserialize(location: lLocation)
#         } else {
#             json[Case.Keys.lastLocation] = nil
#         }
#         if enCase.uploads.count > 0 {
#             var uploadsJSON: [JSON] = []
#             for upload in enCase.uploads {
#                 uploadsJSON.append(self.uploadParser.deserialize(upload: upload))
#             }
#             json[Case.Keys.uploads] = uploadsJSON
#         } else {
#             json[Case.Keys.uploads] = nil
#         }
#         if enCase.messages.count > 0 {
#             var messagesJSON: [JSON] = []
#             for message in enCase.messages {
#                 messagesJSON.append(self.messageParser.deserialize(message: message))
#             }
#             json[Case.Keys.messages] = messagesJSON
#         } else {
#             json[Case.Keys.messages] = nil
#         }
#         return JSON(json)
#     }
# }
