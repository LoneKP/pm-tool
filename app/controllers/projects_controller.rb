class ProjectsController < ApplicationController
	
	def index
	
		#get id saved in database
		  @projects = Project.all.map do |project|
			project.project_data
			end
				
	end				

	def new
		@project = Project.new
		
	end
	
	def create
#		render plain: params[:project].inspect
		@project = Project.new(project_params)
		@project.save
		redirect_to projects_url
	end
	
	def edit
	end

	def destroy
	
	end
	
	private
	def project_params
		params.require(:project).permit(:harvest_project_id)
	end
		
end
