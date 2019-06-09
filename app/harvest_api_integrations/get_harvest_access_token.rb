class GetHarvestAccessToken
  include HTTParty

  def initialize(code, harvest_account_id, organisation)
    @code = code
    @harvest_account_id = harvest_account_id
    @organisation = organisation
  end

  def create_harvest_integration
    harvest_integration = HarvestIntegration.new(harvest_account_id: @harvest_account_id, access_token: access_token, refresh_token: refresh_token, access_token_expiration_time: access_token_expiration_time)
    @organisation.harvest_integration = harvest_integration
  end

  def access_token
    access_token = authorization_code_flow["access_token"]
    "Bearer " + access_token
  end

  def refresh_token
    refresh_token = authorization_code_flow["refresh_token"]
    refresh_token
  end

  def access_token_expiration_time
    access_token_expiration_time = Time.now + authorization_code_flow["expires_in"].seconds
  end

  def authorization_code_flow
    @_authorization_code_flow ||= HTTParty.post("https://id.getharvest.com/api/v2/oauth2/token",
                                                body: {
                                                  code: @code,
                                                  client_id: ENV["HARVEST_CLIENT_ID"],
                                                  client_secret: ENV["HARVEST_CLIENT_SECRET"],
                                                  grant_type: "authorization_code",
                                                }.to_json,
                                                headers: {
                                                  "Content-Type" => "application/json",
                                                })
  end

end
