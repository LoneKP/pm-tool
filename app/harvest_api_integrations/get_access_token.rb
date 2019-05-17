class GetAccessToken
  include HTTParty

  def initialize(code, scope, organisation)
    @code = code
    @scope = scope
    @organisation = organisation
  end

  def create_harvest_integration
    harvest_integration = HarvestIntegration.new(harvest_account_id: harvest_account_id, access_token: access_token, refresh_token: refresh_token, access_token_expiration_time: access_token_expiration_time)
    @organisation.harvest_integration = harvest_integration
  end

  def update_tokens
    @organisation.harvest_integration.update(access_token: updated_access_token)
  end

  def access_token
    access_token = authorization_code_flow["access_token"]
    "Bearer " + access_token
  end

  def refresh_token
    refresh_token = authorization_code_flow["refresh_token"]
    refresh_token
  end

  def updated_access_token
    updated_access_token = post_request_to_update_tokens["access_token"]
    "Bearer " + updated_access_token
  end

  def access_token_expiration_time
    access_token_expiration_time = Time.now + authorization_code_flow["expires_in"].seconds
  end

  def authorization_code_flow
    @_authorization_code_flow ||= HTTParty.post("https://id.getharvest.com/api/v2/oauth2/token",
                                                body: {
                                                  code: @code,
                                                  client_id: ENV["CLIENT_ID"],
                                                  client_secret: ENV["CLIENT_SECRET"],
                                                  grant_type: "authorization_code",
                                                }.to_json,
                                                headers: {
                                                  "Content-Type" => "application/json",
                                                })
  end

  def harvest_account_id
    @scope.gsub(/[^0-9]/, "").to_i
  end

  def post_request_to_update_tokens
    @_post_request_to_update_tokens ||= HTTParty.post("https://id.getharvest.com/api/v2/oauth2/token",
                                                      body: {
                                                        refresh_token: @organisation.harvest_integration.refresh_token,
                                                        grant_type: "refresh_token",
                                                        client_id: ENV["CLIENT_ID"],
                                                        client_secret: ENV["CLIENT_SECRET"],
                                                      }.to_json,
                                                      headers: {
                                                        "Content-Type" => "application/json",
                                                      })
  end
end
