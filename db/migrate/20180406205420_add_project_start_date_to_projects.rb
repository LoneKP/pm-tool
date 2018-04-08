class AddProjectStartDateToProjects < ActiveRecord::Migration[5.1]
  def change
		add_column :projects, :project_start_date, :datetime
  end
end
