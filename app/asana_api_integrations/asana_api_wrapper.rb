class AsanaApiWrapper
  include HTTParty

  def initialize(user)
    @user = user
  end

  def workspaces
    http_response = HTTParty.get(
      "https://app.asana.com/api/1.0/workspaces/",
      headers: headers(
        "https://app.asana.com/api/1.0/workspaces/"
      ),
    )
    #  figure out how to handle when there is no integration. if I rescue I don't get the right return value from this method
    # rescue NoMethodError
    AsanaApiHandler.new(http_response: http_response).data
  end

  def teams
    http_response = HTTParty.get(
      "https://app.asana.com/api/1.0/organizations/164791055906616/teams",
      headers: headers(
        "https://app.asana.com/api/1.0/organizations/164791055906616/teams"
      ),
    )
    AsanaApiHandler.new(http_response: http_response).data
  end

  def projects_in_team(team_id)
    http_response = HTTParty.get(
      "https://app.asana.com/api/1.0/teams/#{team_id}/projects",
      headers: headers(
        "https://app.asana.com/api/1.0/teams/#{team_id}/projects"
      ),
    )
    AsanaApiHandler.new(http_response: http_response).data
  end


  def tasks(project_id)
    http_response = HTTParty.get(
      "https://app.asana.com/api/1.0/projects/#{project_id}/tasks",
      headers: headers(
        "https://app.asana.com/api/1.0/projects/#{project_id}/tasks"
      ),
    )
    AsanaApiHandler.new(http_response: http_response).data
  end

  def task(task_id)
    http_response = HTTParty.get(
      "https://app.asana.com/api/1.0/tasks/#{task_id}",
      headers: headers(
        "https://app.asana.com/api/1.0/tasks/#{task_id}"
      ),
    )
    AsanaApiHandler.new(http_response: http_response).data
  end

  private

  def headers(agent)
    {
      "Authorization" => @user.organisation.asana_integration.access_token,
    }
  end
end

class AsanaApiHandler
  attr_reader :http_response

  def initialize(http_response:)
    @http_response = http_response
  end

  class AsanaInvalidTokenError < StandardError
    def message
      "The token has expired"
    end
  end

  class AsanaTokenDoesNotExistError < StandardError
    def message
      "There is no integration to Asana"
    end
  end

  def data
    if http_response == nil
      raise AsanaTokenDoesNotExistError, "There is no integration to Asana"
    end
    if token_expired?
      raise AsanaInvalidTokenError, "It seems that the token has expired"
    end
    http_response.parsed_response.dig("data")
  end

  def token_expired?
    if http_response.parsed_response.dig("errors") == [{ "message" => "The bearer token has expired. If you have a refresh token, please use it to request a new bearer token, otherwise allow the user to re-authenticate.", "help" => "For more information on API status codes and how to handle them, read the docs on errors: https://asana.com/developers/documentation/getting-started/errors" }]
      true
    else
      false
    end
  end
end
