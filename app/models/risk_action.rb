class RiskAction < ApplicationRecord
	belongs_to :project, inverse_of: :risk_actions, optional: true
	validates_presence_of :project
	
#	validates :risk, :action, presence: true

	class << self
		def create_objects(project_id, list_of_attributes)
			list_of_attributes.map do |attribute|
				RiskAction.create(attribute) do |risk_action|
					risk_action.project_id = project_id
				end
			end
		end
	end

end


