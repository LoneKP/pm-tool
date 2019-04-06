class RemoveOrganizationFromProjects < ActiveRecord::Migration[5.1]
  def change
    remove_reference :projects, :organization, index: true, foreign_key: true
  end
end
