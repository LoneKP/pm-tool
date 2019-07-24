class AddProgressPercentageToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :progress_percentage, :float
  end
end
