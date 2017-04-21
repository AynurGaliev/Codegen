class Relationship

	attr_accessor :name, 
				  :inverseName,
				  :deletionRule,
				  :destinationEntity,
				  :toMany,
				  :is_optional,
				  :inverseEntity

	def initialize(name, inverseName, deletionRule, destinationEntity, toMany, is_optional, inverseEntity)
		@name = name
		@inverseName = inverseName
		@deletionRule = deletionRule
		@destinationEntity = destinationEntity
		@toMany = toMany
		@is_optional = is_optional
		@inverseEntity = inverseEntity
	end

end