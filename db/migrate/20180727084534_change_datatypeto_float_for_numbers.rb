class ChangeDatatypetoFloatForNumbers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :projects do |t|
      t.change :work_hours, :float
      t.change :total_time_hours, :float
    end
  end

  def self.down
    change_table :projects do |t|
      t.change :work_hours, :integer
      t.change :total_time_hours, :integer
    end
  end
end
