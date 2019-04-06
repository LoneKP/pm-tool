class CreateRevenueData < ActiveRecord::Migration[5.1]
  def change
    create_table :revenue_data do |t|
      t.timestamps
      t.string :month
      t.integer :completion_percentage
      t.float :hours_sold_for
      t.float :total_time_hours
      t.float :progressed_hourly_rate
      t.belongs_to :project, index: true
    end
  end
end
