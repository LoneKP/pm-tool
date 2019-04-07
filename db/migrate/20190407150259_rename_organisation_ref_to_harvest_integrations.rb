class RenameOrganisationRefToHarvestIntegrations < ActiveRecord::Migration[5.1]
  def change
    remove_reference :harvest_integrations, :organisations, foreign_key: true
    add_reference :harvest_integrations, :organisation, foreign_key: true
  end
end
