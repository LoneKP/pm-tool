class DeleteAddedToDashboardColumn < ActiveRecord::Migration[5.1]
  def change
		remove_column :projects, :added_to_dashboard
  end
end
