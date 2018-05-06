class AddColorNumberToProjects < ActiveRecord::Migration[5.1]
  def change
		add_column :projects, :color_number, :integer
  end
end
