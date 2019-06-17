class AsanaApiWrapper
  include HTTParty

  def initialize(user)
    @user = user
  end

  def workspaces
    HTTParty.get(
      "https://app.asana.com/api/1.0/workspaces/",
      headers: headers(
        "https://app.asana.com/api/1.0/workspaces/"
      ),
    )
  end

  # def projects
  #   HTTParty.get(
  #     "https://app.asana.com/api/1.0/projects/",
  #     headers: headers(
  #       "https://app.asana.com/api/1.0/projects/"
  #     ),
  #   )
  # end

  def teams
    HTTParty.get(
      "https://app.asana.com/api/1.0/organizations/164791055906616/teams",
      headers: headers(
        "https://app.asana.com/api/1.0/organizations/164791055906616/teams"
      ),
    )
  end

  def projects_in_team(team_id)
    HTTParty.get(
      "https://app.asana.com/api/1.0/teams/#{team_id}/projects",
      headers: headers(
        "https://app.asana.com/api/1.0/teams/#{team_id}/projects"
      ),
    )
  end

  def project(project_id)
    HTTParty.get(
      "https://app.asana.com/api/1.0/projects/#{project_id}",
      headers: headers(
        "https://app.asana.com/api/1.0/projects/#{project_id}"
      ),
    )
  end

  def tasks(project_id)
    HTTParty.get(
      "https://app.asana.com/api/1.0/projects/#{project_id}/tasks",
      headers: headers(
        "https://app.asana.com/api/1.0/projects/#{project_id}/tasks"
      ),
    )
  end

  def task(task_id)
    HTTParty.get(
      "https://app.asana.com/api/1.0/tasks/#{task_id}",
      headers: headers(
        "https://app.asana.com/api/1.0/tasks/#{task_id}"
      ),
    )
  end
 
     private

  def headers(agent)
    {
      "Authorization" => @user.organisation.asana_integration.access_token,
    }
  end
end
