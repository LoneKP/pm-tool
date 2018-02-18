class ProjectsController < ApplicationController
	
	def index
		@user = HTTParty.get("https://api.harvestapp.com/api/v2/users/me.json", 
		headers: 
			{"Harvest-Account-ID" => "575062", 
			"Authorization" => "Bearer 1355453.pt.JsZGJZyBiBaGBLk99LOhY7O6pj5f8WmB1RrL5t890zJBC0_fV_2DPSympTUdcrnLaC2rXesJ53u2aawQnwANCw", 
			"User-Agent" => "https://api.harvestapp.com/api/v2/users/me.json"}).parsed_response
		
		@project = HTTParty.get("https://api.harvestapp.com/api/v2/projects/14830176.json", 
		headers: 
			{"Harvest-Account-ID" => "575062", 
			"Authorization" => "Bearer 1355453.pt.JsZGJZyBiBaGBLk99LOhY7O6pj5f8WmB1RrL5t890zJBC0_fV_2DPSympTUdcrnLaC2rXesJ53u2aawQnwANCw", 
			"User-Agent" => "https://api.harvestapp.com/api/v2/projects/14830176.json"}).parsed_response
		
		@response_time_entries = HTTParty.get("https://api.harvestapp.com/api/v2/time_entries.json", 
		headers: 
			{"Harvest-Account-ID" => "575062", 
			"Authorization" => "Bearer 1355453.pt.JsZGJZyBiBaGBLk99LOhY7O6pj5f8WmB1RrL5t890zJBC0_fV_2DPSympTUdcrnLaC2rXesJ53u2aawQnwANCw", 
			"User-Agent" => "https://api.harvestapp.com/api/v2/time_entries.json"}).parsed_response

		@projects = {}
		
		index = 0
		
		@response_time_entries['time_entries'].each do |time_entry|
			project_id = time_entry.dig('project', 'id')
			project_client = time_entry.dig('client', 'name')
			project_name = time_entry.dig('project', 'name')
			project_hours = time_entry.dig('hours')
			project_billable = time_entry.dig('billable')
			project_task = time_entry.dig('task', 'name' )
			
			
			@projects[index] = {
				"project_name" => project_name,
				"client" => project_client,
				"hours" => project_hours,
				"billable" => project_billable,
				"task" => project_task
				}
		
			index += 1
					
		end
		
	
		
	end
	

	def about
	end
	
	
	
	
end
