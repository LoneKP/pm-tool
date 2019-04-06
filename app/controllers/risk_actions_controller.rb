class RiskActionsController < ApplicationController
  before_action :require_user

  def new
    @risk_action = RiskAction.new
    @project = Project.find(params[:project_id])
  end

  def create
    if params[:commit] == 'Add'
      @risk_action = RiskAction.new(risk_action_params)
      @risk_action.project_id = params[:project_id]
      @risk_action.save
      if @risk_action.save(risk_action_params)
        redirect_to dashboard_url, notice: 'Well done! You have added risk/actions. Now remember to act on them!'
      else
        render 'new'
      end
    elsif params[:commit] == 'Add & create another'
      @risk_action = RiskAction.new(risk_action_params)
      @risk_action.project_id = params[:project_id]
      @risk_action.save
      redirect_to new_project_risk_action_path(params[:project_id])
    end
  end

  def index
    @project = Project.find(params[:project_id])
    @risk_actions = RiskAction.where(project_id: params[:project_id])
    @risk_actions_grouped = @risk_actions.group_by { |x| x.created_at.beginning_of_week }
  end

  def show; end

  private

  def risk_action_params
    params.require(:risk_action).permit(:risk, :action, :work_hours, :completion_percentage, :total_time_hours)
  end
end
