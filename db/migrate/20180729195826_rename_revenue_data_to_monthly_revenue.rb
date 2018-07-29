class RenameRevenueDataToMonthlyRevenue < ActiveRecord::Migration[5.1]

	def self.up
		rename_table :revenue_data, :monthly_revenue
	end

	def self.down
		rename_table :monthly_revenue, :revenue_data
	end

end
