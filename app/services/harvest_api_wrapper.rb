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


	def all_projects(page)
		HTTParty.get(
			"https://api.harvestapp.com/v2/projects?page=#{page}&per_page=100", 
			headers: headers(
				"https://api.harvestapp.com/api/v2/users/me.json"
				)
			).parsed_response
	end

	private
	def headers(agent)
		{
			"Harvest-Account-ID" => ENV.fetch('HARVEST_API_ID'), 
			"Authorization" => "Bearer #{ENV.fetch('HARVEST_API_BEARER')}", 
			"User-Agent" => agent
			}
	end
end

