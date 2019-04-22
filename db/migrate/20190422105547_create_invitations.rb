class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.string :token
      t.string :email
      t.timestamps
    end
    add_reference :invitations, :organisations, foreign_key: true
    add_reference :invitations, :users, foreign_key: true
  end
end
