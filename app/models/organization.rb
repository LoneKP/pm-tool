class Organization < ApplicationRecord
	has_many :users, inverse_of: :organization, autosave: true

	has_many :projects, inverse_of: :organization, autosave: true

end
