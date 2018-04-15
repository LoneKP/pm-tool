class ProjectsController < ApplicationController

	def index
		#get id saved in database
		@projects = Project.all	

	end		

	def revenue
		@projects = Project.all	
	end

	def new
		@project = Project.new	
	end

	def all_projects
		@project = Project.new
		@all_projects = AllProjectsFetcher.new.sort_projects
		@projects = Project.all

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
		@project = Project.delete(project_params)
	end

	private
	def project_params
		params.require(:project).permit(:harvest_project_id)
	end

end
