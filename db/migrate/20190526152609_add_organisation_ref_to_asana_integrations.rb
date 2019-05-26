class AddOrganisationRefToAsanaIntegrations < ActiveRecord::Migration[5.1]
  def change
    add_reference :asana_integrations, :organisation, foreign_key: true
  end
end
