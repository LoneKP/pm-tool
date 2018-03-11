class HarvestApiWrapper
	include HTTParty
	def time_entries
				@response_time_entries_raw = HTTParty.get(
			"https://api.harvestapp.com/api/v2/time_entries.json", 
			headers: headers("https://api.harvestapp.com/api/v2/time_entries.json"
			)
		).parsed_response
	end

	def projects
			response_projects_raw = HTTParty.get(
			"https://api.harvestapp.com/api/v2/projects.json", 
			headers: headers(
				"https://api.harvestapp.com/api/v2/projects.json"
			)
		).parsed_response
	end

	
private
	def headers(agent)
		{
			"Harvest-Account-ID" => ENV.fetch('HARVEST_ACCOUNT_ID', "575062"), 
			"Authorization" => "Bearer 1355453.pt.JsZGJZyBiBaGBLk99LOhY7O6pj5f8WmB1RrL5t890zJBC0_fV_2DPSympTUdcrnLaC2rXesJ53u2aawQnwANCw", 
			"User-Agent" => agent
		}
	end
end
