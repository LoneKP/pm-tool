class AddRefreshTokenToAsanaIntegrations < ActiveRecord::Migration[5.1]
  def change
    add_column :asana_integrations, :refresh_token, :string
    add_column :asana_integrations, :access_token_expiration_time, :datetime
  end
end
