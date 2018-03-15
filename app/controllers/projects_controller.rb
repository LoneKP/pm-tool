class ProjectsController < ApplicationController
	
	def index
	
		#get id saved in database
		  @projects = Project.all.map do |project|
			project.project_data
		
			end
				
	end				

	def new
	end
	
	def edit
	end
	
	def create
	end
	
	def destroy
	end
	
	private
		
end
