class AddAccessTokenToHarvestIntegrations < ActiveRecord::Migration[5.1]
  def change
    add_column :harvest_integrations, :access_token, :string
  end
end
