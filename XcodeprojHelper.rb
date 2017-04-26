require "xcodeproj"

class XcodeprojHelper

	GENERATED_DIR = "Generated"

	def self.openProject(name)
		Xcodeproj::Project.open(name) 
	end

	def self.addGroup(project_name, project, group, parent_group = nil)
		dir_for_generated_files = ""
		if parent_group != nil
			dir_for_generated_files = File.join(parent_group.real_path, group)
		else
			dir_for_generated_files = File.join(Dir.pwd, project_name, GENERATED_DIR, group)
		end
		generated_dir = FileUtils::mkdir_p(dir_for_generated_files)
		new_group = nil
		if parent_group != nil 
			new_group = parent_group.new_group(group, generated_dir.first)
		else 
			new_group = project.new_group(group, generated_dir.first)
		end 
		project.save
		return new_group
	end

	def self.dir_for_generated_files(project_name)
		File.join(Dir.pwd, project_name, GENERATED_DIR)
	end

	def self.add_file(name, content, group, project_name, project, force = true)
		full_path = File.join(group.real_path, name)
		file = File.new(full_path, "w+")
		file.puts content
		file_ref = group.new_file(full_path)
		project.targets.first.source_build_phase.add_file_reference(file_ref)
		project.save
	end 

end
