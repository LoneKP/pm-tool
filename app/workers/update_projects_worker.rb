# Call it like this from the terminal: UpdateProjectsWorker.perform_later
class UpdateProjectsWorker
	include Sidekiq::Worker

	def perform
		Project.joins(:users).uniq.each do |project|
				puts "Fetching data for project #{ project.project_name }"
				ProjectDataFetcher.new(project).call
				ProjectTimeFetcher.new(project).call
		end
		FetchProjects.new.update_projects
	end

end
