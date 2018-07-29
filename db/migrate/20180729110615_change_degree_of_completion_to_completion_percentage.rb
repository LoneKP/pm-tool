class ChangeDegreeOfCompletionToCompletionPercentage < ActiveRecord::Migration[5.1]
  def change
		remove_column :projects, :degree_of_completion
  end
end
