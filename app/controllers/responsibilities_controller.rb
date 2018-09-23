class ResponsibilitiesController < ApplicationController
	
	def create
		@resposibility = Responsibility.new
		@project = Project.find(params[:project_id])
		@user = User.find(6)
		@responsibility.save
	end

	
end