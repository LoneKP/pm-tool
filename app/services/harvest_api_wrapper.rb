class HarvestApiWrapper
	include HTTParty
	
	def project(project_id)
		HTTParty.get(
			"https://api.harvestapp.com/api/v2/projects/#{project_id}.json", 
			headers: headers(
				"https://api.harvestapp.com/api/v2/projects.json"
				)
			).parsed_response				
	end
	
	def time_entries(page, project_id)
		HTTParty.get(
			"https://api.harvestapp.com/v2/time_entries?page=#{page}&per_page=100&project_id=#{project_id}", 
			headers: headers(
			"https://api.harvestapp.com/api/v2/users/me.json"
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
