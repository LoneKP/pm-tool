class AddAsanaProjectIdToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :asana_project_id, :integer
  end
end
