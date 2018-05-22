class AddArchivedProjectsToProjects < ActiveRecord::Migration[5.1]
  def change
		add_column :projects, :archived_projects, :boolean
  end
end
