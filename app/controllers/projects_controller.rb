class ProjectsController < ApplicationController
	
	def index

		#get id saved in database
		  @projects = Project.all.map do |project|
			
				project_id = project.harvest_project_id
	
						response_time_entries_raw = HTTParty.get(
							"https://api.harvestapp.com/v2/time_entries?page=1&per_page=100&project_id=#{project_id}", 
							headers: headers(
							"https://api.harvestapp.com/api/v2/users/me.json"
							)
						).parsed_response	
				
				#Getting the number of pages of the paginated response from projects API	 
					number_of_pages = response_time_entries_raw['total_pages']
					response_time_entries_per_project = []
				
					if number_of_pages == 1 
						response_time_entries_per_project = response_time_entries_raw.dig('time_entries')
					else 
						#for loop to loop through all the pages and fetch all and put into the variable 	response_time_entries_per_project
						for i in 1..number_of_pages do	
							time_entries_raw = HTTParty.get(
									"https://api.harvestapp.com/v2/time_entries?page=#{i}&per_page=100&project_id=#{project_id}", 
									headers: headers(
									"https://api.harvestapp.com/api/v2/users/me.json"
									)
								).parsed_response

							next_array = time_entries_raw['time_entries']

							#add projects array to complete array
							response_time_entries_per_project += next_array

						end

				end
			
				total_time = 0
				design = 0
				programming = 0
				meetings = 0
				project_management = 0
			
				response_time_entries_per_project.each do |time_entry|		
					#set time_per_entry and filter out non-billable time entries
					if time_entry.dig('billable') == true
						time_per_entry = time_entry.dig('hours') 
					else
						time_per_entry = 0
					end

					#Find time spent on specific tasks
					task = time_entry.dig('task', 'name')
					if task == 'Design'
						design += time_per_entry
					end
						if task == 'Programming'
						programming += time_per_entry
					end
						if task == 'Meeting'
						meetings += time_per_entry
					end
						if task == 'Project Management'
						project_management += time_per_entry
					end
					total_time += time_per_entry					
				end
		
				response_projects = HTTParty.get(
				"https://api.harvestapp.com/api/v2/projects/#{project_id}.json", 
				headers: headers(
					"https://api.harvestapp.com/api/v2/projects.json"
					)
				).parsed_response
	
					hours_sold_for = response_projects.dig('budget')	
					project_name = response_projects.dig('name')
					client = response_projects.dig('client', 'name')
				
					percentage = (total_time / hours_sold_for) * 100 
				
			

				{
					"project_id" => project_id,
					"project_name" => project_name,
					"client" => client,
					"hours_sold_for" => hours_sold_for,	
					"total_time" => total_time,
					"programming" => programming,
					"project_management" => project_management,
					"meetings" => meetings,
					"design" => design,
					"percentage" => percentage
				}

			end
				
	end				

	def new
	end
	
	def edit
	end
	
	def create
	end
	
	def destroy
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
