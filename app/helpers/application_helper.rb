module ApplicationHelper

	def current_class?(my_path)
		return 'selected' if request.path == my_path
		''
	end

	def current_class_with_params?(my_path)
		return 'selected' if request.fullpath == my_path
		''
	end

end
