class DITemplate

	def self.generateNetworkModule(header, entities)
		result = ""
		result += header
		result += "import Swinject\n\n"
		result += "final class NetworkModule: Assembly {\n\n"

		#Session Manager
		result += "\tfunc assemble(container: Container) {\n"
		result += "\n\t\tcontainer.register(ISessionManager.self) { (resolver) -> ISessionManager in\n"
		result += "\t\t\treturn SessionManager()\n"
		result += "\t\t}"
		result += "\n\t\t.inObjectScope(.container)\n"
		result += "\t\t.initCompleted { (resolver: Resolver, sessionManager: ISessionManager) in\n"
		result += "\t\t}\n"

		#API
		result += "\n\t\tcontainer.register(IApi.self) { (resolver) -> API in\n"
		result += "\t\t\treturn API()\n"
		result += "\t\t}"
		result += "\n\t\t.inObjectScope(.container)\n"
		result += "\t\t.initCompleted { (resolver: Resolver, sessionManager: IApi) in\n"
		result += "\t\t}\n"

		entity_names = entities.map { |r| r.name }.uniq
		entity_names.each do |name|
			result += "\n\t\tcontainer.register(I#{name}Transport.self) { (resolver: Resolver) -> I#{name}Transport in\n"
			result += "\t\t\treturn #{name}Transport()\n"
			result += "\t\t}\n"
			result += "\t\t.inObjectScope(.container)\n"
			result += "\t\t.initCompleted { (resolver: Resolver, #{name.lowercase_first}Transport: I#{name}Transport!) in\n"
			result += "\t\t\t#{name.lowercase_first}Transport.api = resolver.resolve(IApi.self)!\n"
			result += "\t\t\t#{name.lowercase_first}Transport.#{name.lowercase_first}Parser = resolver.resolve(I#{name}Parser.self)!\n"
			result += "\t\t}\n"
		end
		result += "\t}\n"
		result += "}"
		result
	end

end	
