# Call it like this from the terminal: UpdateProjectsWorker.perform_later
class UpdateProjectsWorker
  include Sidekiq::Worker

  def perform
		Project.all.each do |project|
			puts "Fetching data for project #{ project.project_name }"
    	ProjectDataFetcher.new(project).call
  	end
  end
end
