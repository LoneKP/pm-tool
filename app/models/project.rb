class Project < ApplicationRecord
	after_create :fetch_data_from_harvest_based_on_id 

	def fetch_data_from_harvest_based_on_id
		ProjectDataFetcher.new(Project.last).call
	end

end