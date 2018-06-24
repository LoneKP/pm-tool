module ApplicationHelper

	def current_class?(my_path)
		return 'selected' if request.path == my_path
		''
	end

end
