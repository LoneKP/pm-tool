class ChangeDataTypeForFieldname < ActiveRecord::Migration[5.1]
  def self.up
    change_table :projects do |t|
      t.change :project_end_date, :datetime
    end
  end

  def self.down
    change_table :projects do |t|
      t.change :project_end_date, :date
    end
  end
end
