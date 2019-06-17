class ChangeIntegerLimitOnAsanaProjectIdInProjects < ActiveRecord::Migration[5.1]
  def change
    change_column :projects, :asana_project_id, :integer, limit: 8
  end
end
