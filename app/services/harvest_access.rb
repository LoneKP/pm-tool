class HarvestAccess
  include HTTParty

  def initialize(code)
    @code = code
  end

  def call
    # organisation
    create_or_find_user
    # handle_if_user_has_a_different_organisation
  end

  # def organisation
  #   @_organisation ||= Organisation.where(harvest_account_id: harvest_account_id).first_or_create do |organisation|
  #     organisation.organisation_name = organisation_name
  #     organisation.harvest_account_id = harvest_account_id
  #   end
  # end

  def create_or_find_user
    @user = User.where(email: email).first_or_create do |user|
      user.first_name = first_name
      user.last_name = last_name
      user.email = email
      user.organisation_id = organisation.id
    end
    @user.access_token = access_token
    @user.save
    @user
  end

  # def handle_if_user_has_a_different_organisation
  #   if @user.organisation_id != organisation.id
  #     @user.access_token = access_token
  #     @user.organisation_id = organisation.id
  #     user.first_name = first_name
  #     user.last_name = last_name
  #     @user.save
  #   else
  #     @user
  #   end
  # end

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

  def access_token
    access_token = authorization_code_flow['access_token']
    'Bearer ' + access_token
  end

  def refresh_token
    authorization_code_flow['refresh_token']
  end

  def user_info
    @_user_info ||= HTTParty.get('https://id.getharvest.com/api/v2/accounts',
                                 headers: { 'Authorization' => access_token,
                                            'User-Agent' => 'Prjectio (lk@abtion.com)' })
  end

  def first_name
    @_first_name ||= user_info['user']['first_name']
  end

  def last_name
    @_last_name ||= user_info['user']['last_name']
  end

  def email
    @_email ||= user_info['user']['email']
  end

  def organisation_name
    @_organisation_name ||= user_info['accounts'][0]['name']
  end

  def harvest_account_id
    @_harvest_account_id ||= user_info['accounts'][0]['id']
  end
end
