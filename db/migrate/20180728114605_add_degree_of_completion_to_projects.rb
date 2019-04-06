class AddDegreeOfCompletionToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :degree_of_completion, :integer
  end
end
