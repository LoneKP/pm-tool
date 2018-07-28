class AddDataToRiskActions < ActiveRecord::Migration[5.1]
  def change
		add_column :risk_actions, :work_hours, :integer
		add_column :risk_actions, :completion_percentage, :integer
		add_column :risk_actions, :total_time_hours, :integer
  end
end
