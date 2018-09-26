class ProjectsController < ApplicationController

@user = User.first
	def new
		@project = Project.new	
	end

	def show
		@project = Project.find(params[:id])
		@risk_actions = RiskAction.where(project_id: params[:id])
		@risk_actions_grouped = @risk_actions.group_by{ |x| x.created_at.beginning_of_week }
	end

	def update
		@project = Project.find(params[:id])
		@project.update(project_params)
		@project.responsibilities.create(user:User.first)
		ProjectDataFetcher.new(@project).call
		if @project.update(project_params)
			redirect_to dashboard_url, notice: "Congratulations! You have successfully added/edited a project."
		else
			render 'edit'
		end
	end

	def dashboard
		@user = User.first
		@projects = Project.all
		@risk_actions = RiskAction.all
		@revenue_month = RevenueMonth.new
	end

	def archived_projects
		@archived_projects = Project.all.where(archived:true)
	end

	def index
		@project = Project.new
		@projects = Project.all
		@projects_grouped_by_client = Project.all.group_by { |projects| projects.client_name }
		@user = User.first
	end

	#	def create
	#		#		render plain: params[:project].inspect
	#		@project = Project.new(project_params)
	#		@project.save
	#		redirect_to projects_url
	#	end

	def edit
		@project = Project.find(params[:id])
	end


	def destroy
		@project = Project.find(params[:id])
		@project.destroy
		redirect_to dashboard_url, notice: "You succesfully deleted #{@project.client_name} - #{@project.project_name}"
	end

	private
	def project_params
		params.require(:project).permit(:harvest_project_id, :added_to_dashboard, :work_hours, :hours_sold_for, :project_start_date, :project_end_date, :archived, :evaluation)
	end

end
