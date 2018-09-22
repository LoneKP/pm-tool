class AddDailyStandupTaskToTimeTrackings < ActiveRecord::Migration[5.1]
  def change
		add_column :time_trackings, :total_hours_daily_standup, :float
  end
end
