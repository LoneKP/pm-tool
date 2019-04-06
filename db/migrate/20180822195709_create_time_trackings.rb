class CreateTimeTrackings < ActiveRecord::Migration[5.1]
  def change
    create_table :time_trackings do |t|
      t.datetime :date
      t.float :total_hours
      t.string :task
      t.belongs_to :project, index: true
      t.timestamps
    end
  end
end
