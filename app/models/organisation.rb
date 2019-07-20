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

  def integrations
    harvest_integration = self.harvest_integration
    asana_integration = self.asana_integration
    integrations = harvest_integration, asana_integration
    integrations.compact
  end

  def has_harvest_integration?
    !self.harvest_integration.nil?
  end

  def has_asana_integration?
    !self.asana_integration.nil?
  end

end
