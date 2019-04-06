class ProjectsController < ApplicationController
  has_scope :closed, type: :boolean
  before_action :require_user

  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
    @risk_actions = RiskAction.where(project_id: params[:id])
    @risk_actions_grouped = @risk_actions.group_by { |x| x.created_at.beginning_of_week }
  end

  def update
    @user = current_user
    @project = Project.find(params[:id])
    @project.update(project_params)
    if @project.responsibilities.where(user_id: current_user.id).exists?
      ProjectDataFetcher.new(@project, @user).call
      puts 'the current user already had a relation to this project'
    else
      @project.responsibilities.create(user: current_user)
      ProjectDataFetcher.new(@project, @user).call
      ProjectTimeFetcher.new(@project, @user).call
      puts 'the current user did not have a relation to this project, so the relation was created'
    end

    if @project.update(project_params)
      redirect_to dashboard_url, notice: 'Congratulations! You have successfully added/edited a project.'
    else
      render 'edit', alert: 'Something went wrong'
    end
  end

  def dashboard
    @user = current_user
    @projects = @user.projects.where(closed: false, organisation_id: @user.organisation.id)
    @risk_actions = RiskAction.all
    @revenue_month = RevenueMonth.new
  end

  def revenue
    @user = current_user
  end

  def team
    @user = current_user
    @projects = Project.where(organisation_id: @user.organisation.id, closed: false).joins(:users).uniq
  end

  def closed_projects
    @user = current_user
    @projects = @user.projects.where(closed: true, organisation_id: @user.organisation.id)
  end

  def index
    @user = current_user
    @project = Project.new
    @filtering = params[:filtering]

    if @filtering == 'dashboard'
      @projects = @user.projects.where(closed: false, organisation_id: @user.organisation_id)
    elsif @filtering == 'closed'
      @projects = Project.all.where(closed: true, organisation_id: @user.organisation_id)
    else
      @projects = Project.all.where(closed: false, organisation_id: @user.organisation_id)
    end

    @projects_grouped_by_client = @projects.group_by(&:client_name)
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
