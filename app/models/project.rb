class Project < ApplicationRecord

#	after_commit :update_projects, on: :update
#
#	def update_projects
#		puts "hey"
#		project = Project.order("updated_at").last
#		ProjectDataFetcher.new(project).call
#	end
#	


end