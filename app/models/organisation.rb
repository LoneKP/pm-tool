class Organisation < ApplicationRecord
  has_many :users, inverse_of: :organisation, autosave: true

  has_many :projects, inverse_of: :organisation, autosave: true

  has_one :harvest_integration

  has_many :invitations

  validates :organisation_name,
            presence: true,
            uniqueness: {
              case_sensitive: false,
              message: "Hey! It looks like this organisation already exists in our system. You either need to call it something else or have an admin from your organisation invite you.",
            }
end
