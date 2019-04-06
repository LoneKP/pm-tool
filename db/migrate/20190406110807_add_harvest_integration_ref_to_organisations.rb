class AddHarvestIntegrationRefToOrganisations < ActiveRecord::Migration[5.1]
  def change
    add_reference :organisations, :harvest_integrations, foreign_key: true
  end
end
