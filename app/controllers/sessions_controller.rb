class SessionsController < ApplicationController

	def new

	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		session[:user_id] = user.id
		redirect_to dashboard_url
	end

	def destroy
		session[:user_id] = nil
		redirect_to login_path
	end

	private
	#	def session_params
	#		params.require(:session).permit(:email)
	#	end
end