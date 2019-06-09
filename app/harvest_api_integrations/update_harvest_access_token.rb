class UpdateHarvestAccessToken
    include HTTParty
  
    def initialize(organisation)
      @organisation = organisation
    end
    
    def update_token
      @organisation.harvest_integration.update(access_token: updated_access_token)
    end
  
  
    def updated_access_token
      updated_access_token = post_request_to_update_token["access_token"]
      "Bearer " + updated_access_token
    end
  

    def post_request_to_update_token
      @_post_request_to_update_token ||= HTTParty.post("https://id.getharvest.com/api/v2/oauth2/token",
                                                       body: {
                                                         refresh_token: @organisation.harvest_integration.refresh_token,
                                                         grant_type: "refresh_token",
                                                         client_id: ENV["HARVEST_CLIENT_ID"],
                                                         client_secret: ENV["HARVEST_CLIENT_SECRET"],
                                                       }.to_json,
                                                       headers: {
                                                         "Content-Type" => "application/json",
                                                       })
    end

  end
  