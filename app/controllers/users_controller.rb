class UsersController < ApplicationController
	def create
		code = params[:code]
		scope = params[:scope]

		@result = HTTParty.post('https://id.getharvest.com/api/v2/oauth2/token', 
			:body => { :code => code, :client_id => ENV['CLIENT_ID'], :client_secret => ENV['CLIENT_SECRET'], :grant_type => 'authorization_code'}.to_json, :headers => { 'Content-Type' => 'application/json'} )

		puts @result

		access_token = @result['access_token']
		refresh_token = @result['refresh_token']

		puts access_token
		puts refresh_token

		@user_info = HTTParty.get('https://id.getharvest.com/api/v2/accounts', 
			:headers => { 'Authorization' => 'Bearer ' + access_token,
				'User-Agent' => 'Prjectio (lonekp000@hotmail.com)'
				} )

		puts @user_info
		
		@first_name = @user_info['user']['first_name']
		@last_name = @user_info['user']['last_name']
		@email = @user_info['user']['email']
		
		puts @first_name
		puts @last_name
		puts @email

		#		body = {
		#			grant_type: "authorization_code"
		#			code: params[:code]
		#			redirect_uri: ENV['REDIRECT_URI']
		#			client_id: ENV['CLIENT_ID']
		#			client_secret: ENV['CLIENT_SECRET']
		#			}
		#		auth_response = 
	end
end


