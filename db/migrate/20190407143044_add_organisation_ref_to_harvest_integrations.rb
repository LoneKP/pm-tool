class AddOrganisationRefToHarvestIntegrations < ActiveRecord::Migration[5.1]
  def change
    add_reference :harvest_integrations, :organisations, foreign_key: true
  end
end
