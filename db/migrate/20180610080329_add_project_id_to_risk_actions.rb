class AddProjectIdToRiskActions < ActiveRecord::Migration[5.1]
  def change
    add_column :risk_actions, :project_id, :integer
  end
end
