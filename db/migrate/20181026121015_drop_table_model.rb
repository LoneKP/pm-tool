class DropTableModel < ActiveRecord::Migration[5.1]
  def change
    drop_table :models
  end
end
