class CreateRiskActions < ActiveRecord::Migration[5.1]
  def change
    create_table :risk_actions do |t|
      t.string :risk
      t.string :action
      t.timestamps
    end
  end
end
