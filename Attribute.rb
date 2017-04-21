class Attribute

	attr_accessor :name, 
				  :type,
				  :is_optional

	def initialize(name, type, is_optional)
		@name = name
		@type = type
		@is_optional = is_optional
	end

end