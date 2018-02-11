class ProjectsController < ApplicationController
	
	def home
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
		
		@time_entries = HTTParty.get("https://api.harvestapp.com/api/v2/time_entries.json", 
		headers: 
			{"Harvest-Account-ID" => "575062", 
			"Authorization" => "Bearer 1355453.pt.JsZGJZyBiBaGBLk99LOhY7O6pj5f8WmB1RrL5t890zJBC0_fV_2DPSympTUdcrnLaC2rXesJ53u2aawQnwANCw", 
			"User-Agent" => "https://api.harvestapp.com/api/v2/time_entries.json"}).parsed_response

	end
	

	def about
	end
	
	
	
	
end
