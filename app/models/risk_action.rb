class RiskAction < ApplicationRecord
	belongs_to :project, inverse_of: :risk_actions, optional: true
	validates_presence_of :project
end


