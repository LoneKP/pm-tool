class HardWorker
  include Sidekiq::Worker


  def update_projects(id)
    ProjectDataFetcher.new(Project.find(id)).call
  end
end
