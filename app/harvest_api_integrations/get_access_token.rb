class GetAccessToken
  include HTTParty

  def initialize(code, scope, organisation)
    @code = code
    @scope = scope
    @organisation = organisation
  end

  def create_harvest_integration
    harvest_integration = HarvestIntegration.new(harvest_account_id: harvest_account_id, access_token: access_token)
    @organisation.harvest_integration = harvest_integration
  end

  def access_token
    access_token = authorization_code_flow['access_token']
    'Bearer ' + access_token
  end

  def authorization_code_flow
    @_authorization_code_flow ||= HTTParty.post('https://id.getharvest.com/api/v2/oauth2/token',
                                                body: {
                                                  code: @code,
                                                  client_id: ENV['CLIENT_ID'],
                                                  client_secret: ENV['CLIENT_SECRET'],
                                                  grant_type: 'authorization_code'
                                                }.to_json,
                                                headers: {
                                                  'Content-Type' => 'application/json'
                                                })
  end

  def harvest_account_id
    @scope.gsub(/[^0-9]/, '').to_i
  end
end
