class ChangeDateTypeForLastIntegers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :projects do |t|
      t.change :hours_sold_for, :float
      t.change :programming_hours, :float
      t.change :project_management_hours, :float
      t.change :meetings_hours, :float
      t.change :design_hours, :float
      t.change :completion_percentage, :float
    end
  end

  def self.down
    change_table :projects do |t|
      t.change :hours_sold_for, :integer
      t.change :programming_hours, :integer
      t.change :project_management_hours, :integer
      t.change :meetings_hours, :integer
      t.change :design_hours, :integer
      t.change :completion_percentage, :integer
    end
  end
end
