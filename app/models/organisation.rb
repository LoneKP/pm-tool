class Organisation < ApplicationRecord
  has_many :users, inverse_of: :organisation, autosave: true

  has_many :projects, inverse_of: :organisation, autosave: true
end
