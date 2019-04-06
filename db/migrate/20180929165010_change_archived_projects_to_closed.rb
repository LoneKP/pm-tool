class ChangeArchivedProjectsToClosed < ActiveRecord::Migration[5.1]
  def change
    rename_column :projects, :archived, :closed
  end
end
