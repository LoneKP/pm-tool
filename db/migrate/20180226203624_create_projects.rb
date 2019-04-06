class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.integer :harvest_project_id
      t.string :project_name
      t.string :client_name
      t.integer :hours_sold_for
      t.integer :total_time_hours
      t.integer :programming_hours
      t.integer :project_management_hours
      t.integer :meetings_hours
      t.integer :design_hours
      t.integer :completion_percentage
    end
  end
end
