class DeleteAddedToDashboardFromResponsibilities < ActiveRecord::Migration[5.1]
  def change
    remove_column :responsibilities, :added_to_dashboard
  end
end
