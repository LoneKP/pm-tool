class AddHoursToTimeTrackings < ActiveRecord::Migration[5.1]
  def change
    add_column :time_trackings, :total_hours_design, :float
    add_column :time_trackings, :total_hours_programming, :float
    add_column :time_trackings, :total_hours_project_management, :float
    add_column :time_trackings, :total_hours_meetings, :float
    remove_column :time_trackings, :task
  end
end
