class HeaderTemplate

	def self.generateHeader(project_name, file_name)
		header = "//\n"
		header += "// #{file_name}\n"
		header += "// #{project_name}\n"
		header += "//\n"
		header += "// Created by Codegen on #{Time.now.strftime("%d/%m/%Y %H:%M")}.\n"
		header += "// Copyright © 2017 Codegen. All rights reserved.\n"
		header += "//\n\n"
		header += "import Foundation\n\n"
		return header
	end
end
