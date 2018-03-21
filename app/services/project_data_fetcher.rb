class ProjectDataFetcher
	def initializer(project)
		@project = project
	
	end
	
	def call
		project.design_hours
		@project.save
	end
end