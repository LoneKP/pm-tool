class ChangeNameOfArchivedProjectsColumn < ActiveRecord::Migration[5.1]
  
	 def change
    rename_column :projects, :archived_projects, :archived
  end
end
