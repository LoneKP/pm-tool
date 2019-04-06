class RemoveHarvestAccountIdFromOrganisations < ActiveRecord::Migration[5.1]
  def change
    remove_column :organisations, :harvest_account_id, :integer
  end
end
