class AddHarvestAccountIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :harvest_account_id, :integer
  end
end
