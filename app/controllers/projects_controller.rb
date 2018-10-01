class ProjectsController < ApplicationController


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
		if @project.responsibilities.where(user_id:current_user.id).exists?
			ProjectDataFetcher.new(@project).call
			puts 'the current user already had a relation to this project'
		else
			@project.responsibilities.create(user:current_user)
			ProjectDataFetcher.new(@project).call
			puts 'the current user did not have a relation to this project, so the relation was created'
		end

		if @project.update(project_params)
			redirect_to dashboard_url, notice: "Congratulations! You have successfully added/edited a project."
		else
			render 'edit', alert: "Something went wrong"
		end
	end

	def dashboard
		@user = current_user
		@projects = Project.all
		@risk_actions = RiskAction.all
		@revenue_month = RevenueMonth.new
	end
	
	def revenue
		@user = current_user
	end

	def closed_projects
		@user = current_user
		@closed_projects = Project.all.where(closed:true)	
	end

	def index
		@project = Project.new
		@projects = Project.all
		@projects_grouped_by_client = Project.all.group_by { |projects| projects.client_name }
		@user = current_user
	end

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
		params.require(:project).permit(:harvest_project_id, :added_to_dashboard, :work_hours, :hours_sold_for, :project_start_date, :project_end_date, :closed, :evaluation)
	end

end
