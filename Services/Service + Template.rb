class ServiceTemplate

	def self.generateServiceTemplate(entity, header)
		result = ""
		result += header
		result += "protocol I#{entity.name}Service: class {\n"
		result += "\t//MARK: - Interface definition goes here...\n"
		result += "}\n\n"
		result += "final class #{entity.name}Service: I#{entity.name}Service {\n"
		result += "}\n"
		return result
	end
end