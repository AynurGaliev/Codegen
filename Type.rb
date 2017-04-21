class Type

	def self.convertToSwiftType(type)

		result_type = case type 
		when "Date"          then 'Date'
		when "Integer 16"    then 'Int'
		when "Integer 32"    then 'Int'
		when "Integer 64"    then 'Int'
		when "Decimal"       then 'NSNumber'
		when "Double"        then 'Double'
		when "Float"         then 'Float'
		when "Boolean"       then 'Bool'
		when "Undefined"     then 'Any'
		when "Transformable" then 'Any'
		when "String"        then 'String'
		when "Binary"		 then 'Data'
		else 'Any'
		end
		
		result_type

	end

end
