# Call it like this from the terminal: UpdateProjectsWorker.perform_later
class UpdateProjectsWorker
	include Sidekiq::Worker
	
	def perform
		Project.all.where(added_to_dashboard:true).each do |project|
			puts "Fetching data for project #{ project.project_name }"
			ProjectDataFetcher.new(project).call
		end
		FetchProjects.new.update_projects
	end
	
end
