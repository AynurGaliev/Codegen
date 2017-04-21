class Entity 

	attr_accessor :name, 
				  :attributes,
				  :relationships,
				  :parent,
				  :children

	def initialize(name, attributes, relationships)
		@name = name
		@attributes = attributes
		@relationships = relationships
		@parent = nil
		@children = Array.new
	end

end 