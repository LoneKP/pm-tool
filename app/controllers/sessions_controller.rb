class SessionsController < ApplicationController

	def new

	end

	def create
		@code = params[:code]
		harvest_user = UserCredentialsFetcher.new(@code).call
		email = harvest_user['email']
		first_name = harvest_user['first_name']
		last_name = harvest_user['last_name']
		organization = harvest_user['organization']

		if User.exists?(:email => email)
			user = User.find_by(email: email)
			session[:user_id] = user.id
			redirect_to dashboard_url
		else
			puts 'user doesnt exist already - create new user'
			user = User.create(first_name: first_name, last_name: last_name, email: email, organization: organization)
			session[:user_id] = user.id
			redirect_to dashboard_url
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to login_path
	end

end