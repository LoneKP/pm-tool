class HarvestApiWrapper
  include HTTParty

  def initialize(user)
    @user = user
  end

  def project(project_id)
    HTTParty.get(
      "https://api.harvestapp.com/api/v2/projects/#{project_id}.json",
      headers: headers(
        'https://api.harvestapp.com/api/v2/projects.json'
      )
    ).parsed_response
  end

  def user_info
    HTTParty.get(
      'https://id.getharvest.com/api/v2/accounts',
      headers: headers(
        'https://api.harvestapp.com/api/v2/projects.json'
      )
    ).parsed_response
  end

  def time_entries(page, project_id)
    HTTParty.get(
      "https://api.harvestapp.com/v2/time_entries?page=#{page}&per_page=100&project_id=#{project_id}",
      headers: headers(
        'https://api.harvestapp.com/api/v2/users/me.json'
      )
    ).parsed_response
  end

  def all_projects(page)
    response = HTTParty.get(
      "https://api.harvestapp.com/v2/projects?page=#{page}&per_page=100",
      headers: headers(
        'https://api.harvestapp.com/api/v2/users/me.json'
      )
    ).parsed_response

    if response.key?('error')
      p response
      raise 'login error'
    end

    response
  end

  #    private

  def headers(agent)
    {
      'Authorization' => @user.access_token,
      'Harvest-Account-Id' => @user.organisation.harvest_account_id.to_s,
      'User-Agent' => agent
    }
  end
end
