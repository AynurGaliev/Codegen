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
		new_group = self.createNewGroup(project, group, parent_group, generated_dir.first)
		project.save
		return new_group
	end

	def self.createNewGroup(project, group, parent_group, path)

		if parent_group != nil 
			existingGroup = self.recursiveGroupsForGroup(parent_group).find { |g| g.name == group }
			if existingGroup == nil 
				existingGroup = parent_group.new_group(group, path)
			end
			return existingGroup
		else 
			existingGroup = self.recursiveGroupsForProject(project).find { |g| g.name == group }
			if existingGroup == nil 
				existingGroup = project.new_group(group, path)
			end
			return existingGroup
		end 

	end

	def self.recursiveGroupsForGroup(group)
		child_groups = Array.new
		if group == nil
			return child_groups
		else 
			child_groups = child_groups + group.groups
			group.groups.each do |g|
				child_groups = child_groups + recursiveGroupsForGroup(g) 
			end
			return child_groups
		end
	end

	def self.recursiveGroupsForProject(project)
		child_groups = project.groups
		project.groups.each do |g|
			child_groups = child_groups + recursiveGroupsForGroup(g) 
		end
		return child_groups
	end

	def self.add_file(name, content, group, project, rewrite = false)
		full_path = File.join(group.real_path, name)
		if !rewrite
			if !File.exists?(full_path)
				saveFile(full_path, content, group, project, true)
			end
		else 
			saveFile(full_path, content, group, project, !File.exists?(full_path))
		end
	end 

	def self.saveFile(full_path, content, group, project, createBefore)
		file = nil
		if createBefore
			file = File.new(full_path, "w+")
		else 
			file = File.open(full_path, "w+")
		end
		file.puts content
		existing_file = group.files.find { |f| f.real_path.to_s == full_path }
		if existing_file == nil
			file_ref = group.new_file(full_path)
			project.targets.first.source_build_phase.add_file_reference(file_ref)
		end
		project.save
	end

end
