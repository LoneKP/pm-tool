class CreateAssignedProjectsTable < ActiveRecord::Migration[5.1]
	def change
		create_table :assigned_projects do |t|
			t.belongs_to :project, index: true
			t.belongs_to :user, index: true
			t.boolean :added_to_dashboard
			t.timestamps
		end
	end
end



