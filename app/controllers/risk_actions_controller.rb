class RiskActionsController < ApplicationController

	def new
		@risk_action = RiskAction.new
		@project = Project.find(params[:project_id])
	end

	def create
		@risk_action = RiskAction.create_objects(params[:project_id], risk_action_params)
		redirect_to project_risk_actions_path(params[:project_id])
	end

	def index
		@project = Project.find(params[:project_id])
		@risk_actions = RiskAction.where(project_id: params[:project_id])
		@risk_actions_grouped = @risk_actions.group_by{ |x| x.created_at.beginning_of_week }
	end

	def show
	end

	private
	def risk_action_params
		params[:risk_actions].map {|param| param.permit(:risk, :action)}
		
	end


end