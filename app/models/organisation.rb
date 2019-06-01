class Organisation < ApplicationRecord
  has_many :users, inverse_of: :organisation, autosave: true

  has_many :projects, inverse_of: :organisation, autosave: true

  has_one :harvest_integration
  has_one :asana_integration

  has_many :invitations

  validates :organisation_name,
            presence: true,
            uniqueness: {
              case_sensitive: false,
              message: "Hey! It looks like this organisation already exists in our system. You either need to call it something else or have an admin from your organisation invite you.",
            }

  def has_harvest_integration?
    !self.harvest_integration.nil?
  end

  def harvest_access_token_expired?
    self.harvest_integration.access_token_expiration_time < Time.now
  end

  def integrations
    harvest_integration = self.harvest_integration
    asana_integration = self.asana_integration
    integrations = harvest_integration, asana_integration
  end

end
