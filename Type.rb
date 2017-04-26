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
		else 'Data'
		end
		
		result_type
	end

	def self.defaultValue(type)

		default_value = case type
		when "Date"			then "Date()"
		when "Int"			then "0"
		when "NSNumber"		then "0"
		when "Double"		then "0.0"
		when "Float"		then "0.0"
		when "Bool"			then "false"
		when "String"		then "\"\""
		when "Data"			then "Data()"
		when "NSDictionary" then "NSDictionary()"	
		else "\"\""
		end

		return default_value
	end

end
