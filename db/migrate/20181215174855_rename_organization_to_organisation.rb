class RenameOrganizationToOrganisation < ActiveRecord::Migration[5.1]
  def change
    rename_column :organizations, :organization_name, :organisation_name
    rename_table :organizations, :organisations
  end
end
