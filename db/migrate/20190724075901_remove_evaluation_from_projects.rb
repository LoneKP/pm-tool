class RemoveEvaluationFromProjects < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :evaluation, :string
  end
end
