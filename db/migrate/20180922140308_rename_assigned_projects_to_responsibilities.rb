class RenameAssignedProjectsToResponsibilities < ActiveRecord::Migration[5.1]
  def change
    rename_table :assigned_projects, :responsibilities
  end
end
