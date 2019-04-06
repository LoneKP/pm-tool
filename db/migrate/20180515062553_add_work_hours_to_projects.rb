class AddWorkHoursToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :work_hours, :integer
  end
end
