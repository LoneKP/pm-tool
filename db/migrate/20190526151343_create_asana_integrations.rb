class CreateAsanaIntegrations < ActiveRecord::Migration[5.1]
  def change
    create_table :asana_integrations do |t|
      t.string :access_token
      t.timestamps
    end
  end
end
