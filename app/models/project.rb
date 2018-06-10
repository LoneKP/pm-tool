class Project < ApplicationRecord
	has_many :risk_actions, inverse_of: :project, autosave: true
	accepts_nested_attributes_for :risk_actions

end



