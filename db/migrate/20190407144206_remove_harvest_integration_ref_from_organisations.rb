class RemoveHarvestIntegrationRefFromOrganisations < ActiveRecord::Migration[5.1]
  def change
    remove_reference :organisations, :harvest_integrations, foreign_key: true
  end
end
