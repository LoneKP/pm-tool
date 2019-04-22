class ChangeForeignKeysInInvitationsToBeSingular < ActiveRecord::Migration[5.1]
  def change
    remove_reference :invitations, :organisations, foreign_key: true
    remove_reference :invitations, :users, foreign_key: true
    add_reference :invitations, :organisation, foreign_key: true
    add_reference :invitations, :user, foreign_key: true
  end
end
