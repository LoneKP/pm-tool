class RenameMonthlyRevenueToRevenueMonths < ActiveRecord::Migration[5.1]
  def self.up
    rename_table :monthly_revenue, :revenue_months
  end

  def self.down
    rename_table :revenue_months, :monthly_revenue
  end
end
