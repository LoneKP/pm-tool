class AddEvaluationToProjects < ActiveRecord::Migration[5.1]
  def change
		add_column :projects, :evaluation, :string
  end
end
