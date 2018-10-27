class UsersController < ApplicationController
	def create
		@code = params[:code]
		scope = params[:scope]
		
		UserCredentialsFetcher.new(@code).call
		
	end
end


