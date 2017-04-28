class StorageTemplate

	def self.generateStorageEntitiesTemplate(entity, header)
		result = ""
		result += header
		result += "protocol I#{entity.name}Storage: class {\n"
		result += "\tvar storage: IStorage! { get set }\n"
		result += "}\n\n"
		result += "final class #{entity.name}Storage: I#{entity.name}Storage {\n\n"
		result += "\t//MARK: - Dependencies\n"
		result += "\tvar storage: IStorage!\n"
		result += "}"
		return result
	end

	def self.generateStorageTemplate(header)
		result = ""
		result += header
		result += "protocol IStorage: class {\n"
		result += "\n\t//MARK: - Sync interface\n\n"
		result += "\n\t//MARK: - Async interface\n\n"
		result += "}\n\n"
		result += "final class Storage: IStorage {\n"
		result += "\n}\n"
		return result
	end

end