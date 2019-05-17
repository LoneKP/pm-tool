class AddRefreshTokenToHarvestIntegrations < ActiveRecord::Migration[5.1]
  def change
    add_column :harvest_integrations, :refresh_token, :string
  end
end
