class TransportTemplate

	def self.generateTransportTemplate(entity, header)
		result = ""
		result += header
		result += "protocol I#{entity.name}Transport: class {\n"
		result += "\tvar api: IApi! { get set }\n"
		result += "\tvar #{entity.name.lowercase_first}Parser: I#{entity.name}Parser! { get set }\n"
		result += "}\n\n"
		result += "final class #{entity.name}Transport: I#{entity.name}Transport {\n\n"
		result += "\t//MARK: - Dependencies\n"
		result += "\tvar api: IApi!\n"
		result += "\tvar #{entity.name.lowercase_first}Parser: I#{entity.name}Parser!\n"
		result += "}\n"
		return result
	end

	def self.generateApi(header)
		result = ""
		result += header
		result += "protocol IApi: class {\n"
		result += "\tfunc makeRequest(url: URL, method: String, params: [String : Any]?, onSuccess: ((Data) -> Void), onFailure: ((Error) -> Void))\n"
		result += "\tvar sessionManager: ISessionManager! { get set }\n"
		result += "}\n\n"
		result += "final class API: IApi {\n\n"
		result += "\t//MARK: - Dependencies\n"
		result += "\tvar sessionManager: ISessionManager!\n\n"
		result += "\t//MARK: - Implementation\n"
		result += "\tfunc makeRequest(url: URL, method: String, params: [String : Any]?, onSuccess: ((Data) -> Void), onFailure: ((Error) -> Void)) { }\n"
		result += "}\n"
	end

	def self.generateSessionManager(header)
		result = ""
		result += header
		result += "protocol ISessionManager: class {\n"
		result += "}\n\n"
		result += "final class SessionManager: ISessionManager {\n"
		result += "}\n"
	end

	def self.generateRouter(header)
		result = ""
		result += header
		result += "enum Router {\n\n"
		result += "\tprivate static var baseURL: URL = URL(string: \"\")!\n"
		result += "}\n"
	end
end