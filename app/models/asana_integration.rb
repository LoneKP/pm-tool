class AsanaIntegration < ApplicationRecord
  belongs_to :organisation

  def type
    "Asana"
  end

  def connect_project_path(project)
    Rails.application.routes.url_helpers.project_connect_asana_projects_path(project)
  end

end
