class CreateUnaddedProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :unadded_projects do |t|
      t.string :project_name
      t.string :client_name
      t.integer :harvest_project_id
    end
  end
end
