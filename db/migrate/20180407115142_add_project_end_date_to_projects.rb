class AddProjectEndDateToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :project_end_date, :date
  end
end
