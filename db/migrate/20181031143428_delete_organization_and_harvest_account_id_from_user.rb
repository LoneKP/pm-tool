class DeleteOrganizationAndHarvestAccountIdFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :organization
    remove_column :users, :harvest_account_id
  end
end
