class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
			t.integer :harvest_project_id
    end
  end
end
