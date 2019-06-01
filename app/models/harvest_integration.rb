class HarvestIntegration < ApplicationRecord
  belongs_to :organisation

def type
  'Harvest'
end

def connect_project_path(project)
  Rails.application.routes.url_helpers.project_connect_harvest_projects_path(project)
end

end
