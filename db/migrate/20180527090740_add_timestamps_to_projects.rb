class AddTimestampsToProjects < ActiveRecord::Migration[5.1]
  def change
    add_timestamps :projects, default: DateTime.now
    change_column_default :projects, :created_at, nil
    change_column_default :projects, :updated_at, nil
  end
end
