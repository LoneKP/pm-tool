class RenameTokenExpirationTimeToAccessTokenExpirationTime < ActiveRecord::Migration[5.1]
  def change
    rename_column :harvest_integrations, :token_expiration_time, :access_token_expiration_time
  end
end
