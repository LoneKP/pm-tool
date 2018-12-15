class AddOrganizationToProjectsAndUsers < ActiveRecord::Migration[5.1]
  def change
		add_reference :projects, :organisation, foreign_key: true
		add_reference :users, :organisation, foreign_key: true
  end
end
