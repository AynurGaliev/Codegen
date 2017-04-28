class ServiceTemplate

	def self.generateServiceTemplate(entity, header)
		result = ""
		result += header
		result += "protocol I#{entity.name}Service: class {\n"
		result += "\tvar #{entity.name.lowercase_first}Serializer: I#{entity.name}Serializer! { get set }\n"
		result += "\tvar #{entity.name.lowercase_first}Storage: I#{entity.name}Storage! { get set }\n"
		result += "\tvar #{entity.name.lowercase_first}Transport: I#{entity.name}Transport! { get set }\n"
		result += "}\n\n"
		result += "final class #{entity.name}Service: I#{entity.name}Service {\n\n"
		result += "\tvar #{entity.name.lowercase_first}Serializer: I#{entity.name}Serializer!\n"
		result += "\tvar #{entity.name.lowercase_first}Storage: I#{entity.name}Storage!\n"
		result += "\tvar #{entity.name.lowercase_first}Transport: I#{entity.name}Transport!\n"
		result += "}\n"
		return result
	end
end