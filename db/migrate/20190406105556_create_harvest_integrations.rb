class CreateHarvestIntegrations < ActiveRecord::Migration[5.1]
  def change
    create_table :harvest_integrations do |t|
      t.integer :harvest_account_id
    end
  end
end
