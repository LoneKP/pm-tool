class UpdateAccessToken
  include HTTParty

  def initialize(organisation)
    @organisation = organisation
  end

  def update_access_token
    @organisation.harvest_integration.update(access_token: access_token, access_token_expiration_time: access_token_expiration_time)
  end

  def access_token
    access_token = post_request_to_update_tokens["access_token"]
    "Bearer " + access_token
  end

  def access_token_expiration_time
    access_token_expiration_time = Time.now + post_request_to_update_tokens["expires_in"].seconds
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
