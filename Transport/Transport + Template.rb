class TransportTemplate

	def self.generateTransportTemplate(entity, header)
		result = ""
		result += header
		result += "protocol I#{entity.name}Transport: class {\n"
		result += "\t//TODO: - Interface goes here..\n}\n\n"
		result += "final class #{entity.name}Transport: I#{entity.name}Transport {\n"
		result += "\t//TODO: - Interface implementation goes here..\n}\n"
		return result
	end
end