class AddAccessTokenExpirationTimeToHarvestIntegrations < ActiveRecord::Migration[5.1]
  def change
    add_column :harvest_integrations, :token_expiration_time, :datetime
  end
end
