class ProjectsController < ApplicationController
  before_action :require_user

  def new
    @user = current_user
    @project = Project.new
  end

  def create
    @user = current_user
    @project = Project.new(project_params)
    @project.organisation = current_user.organisation
    if @project.save
      flash.now[:notice] = "Project created"
      redirect_to project_choose_data_sources_path(@project)
    else
      render "new"
    end
  end

  def choose_data_sources
    @user = current_user
    @project = Project.find(params[:project_id])
    @integrations = @project.organisation.integrations
    @possible_integrations = ["Harvest", "Asana", "Jira", "Trello"]
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
      puts "the current user already had a relation to this project"
    else
      @project.responsibilities.create(user: current_user)
      ProjectDataFetcher.new(@project, @user).call
      ProjectTimeFetcher.new(@project, @user).call
      puts "the current user did not have a relation to this project, so the relation was created"
    end

    if @project.update(project_params)
      redirect_to dashboard_url, notice: "Congratulations! You have successfully added/edited a project."
    else
      render "edit", alert: "Something went wrong"
    end
  end

  def dashboard
    @user = current_user
    @projects = @user.projects.where(organisation_id: @user.organisation.id)
    @risk_actions = RiskAction.all
    @revenue_month = RevenueMonth.new
  end

  def team
    @user = current_user
    @projects = Project.where(organisation_id: @user.organisation.id, closed: false).joins(:users).uniq
  end

  def closed_projects
    @user = current_user
    @projects = @user.projects.where(closed: true, organisation_id: @user.organisation.id)
  end

  def connect_harvest_projects
    @project = Project.find(params[:project_id])
    @user = current_user
    @organisation = @user.organisation
    @harvest_projects = fetch_harvest_projects
    @projects_grouped_by_client = @harvest_projects.group_by { |project| project['client_name'] }
  end

  def adjust_harvest_projects
    @user = current_user
    @project = Project.find(params[:project_id])
    @harvest_project = harvest_project_params
    @project.update(
      hours_sold_for: @harvest_project['hours_sold_for'], 
      project_start_date: @harvest_project['project_start_date'],
      project_end_date: @harvest_project['project_end_date'],
      client_name: @harvest_project['client_name'],
      harvest_project_id: @harvest_project['harvest_project_id'],
      )
    redirect_to edit_project_path(@project)
  end

  def connect_asana_projects
    @project = Project.find(params[:project_id])
    @user = current_user
    @organisation = @user.organisation
    @asana_projects = fetch_asana_projects
  end

  def adjust_asana_projects
    @user = current_user
    @project = Project.find(params[:project_id])
    @asana_project = asana_project_params
    @project.update(
      asana_project_id: @asana_project['project_id']
    )
  end

  def edit
    @project = Project.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to dashboard_url, notice: "You succesfully deleted #{@project.client_name} - #{@project.project_name}"
  end

  def fetch_harvest_projects
      update_access_tokens_if_they_have_expired(@organisation)
      FetchHarvestProjects.new(@user).harvest_projects
  end

  def fetch_asana_projects
    update_access_tokens_if_they_have_expired(@organisation)
    FetchAsanaProjects.new(@user).asana_projects_grouped_by_team
  end

  def update_access_tokens_if_they_have_expired(organisation)
    organisation.integrations.each do |integration|
      if Time.current > integration.access_token_expiration_time
        if integration.type == "Asana"
          UpdateAsanaAccessToken.new(organisation).update_token
        elsif integration.type == "Harvest"
          UpdateHarvestAccessToken.new(organisation).update_token
        end
      end
    end
  end

  private

  def project_params
    params.require(:project).permit(:project_name, :harvest_project_id, :added_to_dashboard, :work_hours, :hours_sold_for, :project_start_date, :project_end_date, :closed, :evaluation)
  end

  def harvest_project_params
    params.require(:harvest_project).permit(
      :project_name, 
      :harvest_project_id, 
      :hours_sold_for, 
      :project_start_date, 
      :project_end_date, 
      :client_name
      )
  end

  def asana_project_params
    params.require(:asana_project).permit(
      :team_name, 
      :team_id, 
      :project_name, 
      :project_id
      )
  end
end
