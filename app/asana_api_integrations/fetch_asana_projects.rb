class FetchAsanaProjects
  def initialize(user)
    @user = user
  end

  def asana_projects_grouped_by_team
    asana_projects_with_no_empty_arrays.group_by { |team| team[0]["team_name"] }
  end

  def asana_projects_with_no_empty_arrays
    asana_projects.reject!(&:blank?)
  end

  def asana_projects
    teams.map do |team|
      team_name = team["name"]
      team_id = team["gid"]

      all_projects(team_id).map do |project|
        project_name = project["name"]
        project_id = project["gid"]

        asana_projects = Hash.new
        asana_projects["team_name"] = team_name
        asana_projects["team_id"] = team_id
        asana_projects["project_name"] = project_name
        asana_projects["project_id"] = project_id

        asana_projects
      end
    end
  end

  def all_projects(team_id)
    wrapper(@user).projects_in_team(team_id)
  end

  def teams
    wrapper(@user).teams
  end
  
  def wrapper(_user)
    @_wrapper ||= AsanaApiWrapper.new(@user)
  end

  private
end
