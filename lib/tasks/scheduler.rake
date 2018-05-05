desc "This task is called by the Heroku scheduler add-on"
task :update_projects => :environment do
  puts "Updating projects..."
  UpdateProjectsWorker.perform_in(2.minutes)
  puts "done."
end
