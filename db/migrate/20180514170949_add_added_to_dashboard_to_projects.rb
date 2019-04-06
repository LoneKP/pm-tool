class AddAddedToDashboardToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :added_to_dashboard, :boolean
  end
end
