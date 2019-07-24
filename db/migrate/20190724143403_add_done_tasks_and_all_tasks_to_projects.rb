class AddDoneTasksAndAllTasksToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :done_tasks_count, :float
    add_column :projects, :all_tasks_count, :float
  end
end