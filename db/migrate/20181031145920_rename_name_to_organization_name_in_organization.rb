class RenameNameToOrganizationNameInOrganization < ActiveRecord::Migration[5.1]
  def change
    rename_column :organizations, :name, :organization_name
  end
end
