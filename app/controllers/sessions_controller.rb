class SessionsController < ApplicationController

	def new

	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user != nil
			session[:user_id] = user.id
			redirect_to dashboard_url
		else
			puts "user does not exist"
			redirect_to login_path, alert: "Sorry! This user does not exist - please try with a different email"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to login_path
	end

end