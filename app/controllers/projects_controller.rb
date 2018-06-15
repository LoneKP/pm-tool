class ProjectsController < ApplicationController


	def new
		@project = Project.new	
	end

	def show
	end

	def update
		@project = Project.find(params[:id])
		@project.update(project_params)
		ProjectDataFetcher.new(@project).call
		redirect_to dashboard_url		
	end

	def dashboard
		@projects = Project.all.where(added_to_dashboard:true)
	end
	
	def archived_projects
		@archived_projects = Project.all.where(archived:true)
	end

	def index
		@project = Project.new
		@projects = Project.all
		@projects_grouped_by_client = Project.all.group_by { |projects| projects.client_name }
	end

	def create
		#		render plain: params[:project].inspect
		@project = Project.new(project_params)
		@project.save
		redirect_to projects_url
	end

	def edit
		@project = Project.find(params[:id])
	end


	def destroy
		@project = Project.find(params[:id])
		@project.destroy
		redirect_to dashboard_url
	end

	private
	def project_params
		params.require(:project).permit(:harvest_project_id, :added_to_dashboard, :work_hours, :hours_sold_for, :project_start_date, :project_end_date, :archived)
	end

end
