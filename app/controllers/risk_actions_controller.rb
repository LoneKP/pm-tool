class RiskActionsController < ApplicationController

	def new
		@risk_action = RiskAction.new
		@risk_action.save

	end

	def create
		@risk_action = RiskAction.new(risk_action_params)
		@risk_action.project_id = params[:project_id]
		@risk_action.save
		p @risk_action.errors.full_messages
		#		binding.pry
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
		params.require(:risk_action).permit(:risk, :action)
	end


end