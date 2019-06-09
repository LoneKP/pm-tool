class UpdateAsanaAccessToken
    include HTTParty
  
    def initialize(organisation)
      @organisation = organisation
    end
  
    def update_token
      @organisation.asana_integration.update(access_token: updated_access_token)
    end
  
    def updated_access_token
      updated_access_token = post_request_to_update_token.parsed_response["access_token"]
      "Bearer " + updated_access_token
    end
  
    def post_request_to_update_token
      @_post_request_to_update_token ||= HTTParty.post("https://app.asana.com/-/oauth_token",
                                                        body: {
                                                          refresh_token: @organisation.asana_integration.refresh_token,
                                                          grant_type: "refresh_token",
                                                          client_id: ENV["ASANA_CLIENT_ID"],
                                                          client_secret: ENV["ASANA_CLIENT_SECRET"],
                                                        }
                                                       )
    end
  end
  