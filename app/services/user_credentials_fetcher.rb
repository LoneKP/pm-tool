
class UserCredentialsFetcher
	include HTTParty

	def initialize(code)
		@code = code
	end

	def call
		@user = {'first_name' => first_name, 'last_name' => last_name, 'email' => email, 'organization' => organization}
	end

	def get_credentials
		@_get_credentials ||= HTTParty.post('https://id.getharvest.com/api/v2/oauth2/token', 
			:body => { :code => @code, :client_id => ENV['CLIENT_ID'], :client_secret => ENV['CLIENT_SECRET'], :grant_type => 'authorization_code'}.to_json, :headers => { 'Content-Type' => 'application/json'} )
	end

	def access_token
		access_token = get_credentials['access_token']
		'Bearer ' + access_token

	end

	def refresh_token
		get_credentials['refresh_token']
	end

	def user_info
		@_user_info ||= HTTParty.get('https://id.getharvest.com/api/v2/accounts', 
			:headers => { 'Authorization' => access_token,
				'User-Agent' => 'Prjectio (lonekp000@hotmail.com)'
				} )
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

	def organization
		@_organization ||= user_info['accounts'][0]['name']
	end

end