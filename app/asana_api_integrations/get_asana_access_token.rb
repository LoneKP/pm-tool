class GetAsanaAccessToken
    include HTTParty
  
    def initialize(code, organisation)
      @code = code
      @organisation = organisation
    end
  
    def create_asana_integration
      asana_integration = AsanaIntegration.new(access_token: access_token, refresh_token: refresh_token, access_token_expiration_time: access_token_expiration_time)
      @organisation.asana_integration = asana_integration
    end
  
    def access_token
      access_token = authorization_code_flow.parsed_response["access_token"]
      "Bearer " + access_token
    end
  
    def refresh_token
      refresh_token = authorization_code_flow.parsed_response["refresh_token"]
      refresh_token
    end
 
    def access_token_expiration_time
      access_token_expiration_time = Time.current + authorization_code_flow.parsed_response["expires_in"].seconds
    end
  
    def authorization_code_flow
      @_authorization_code_flow ||= HTTParty.post("https://app.asana.com/-/oauth_token",
                                                  body: {
                                                    code: @code,
                                                    client_id: ENV["ASANA_CLIENT_ID"],
                                                    client_secret: ENV["ASANA_CLIENT_SECRET"],
                                                    grant_type: "authorization_code",
                                                    redirect_uri: "http://localhost:3000/asana_callback",
                                                  }
                                                )
    end
  
  end
  