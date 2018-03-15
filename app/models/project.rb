class Project < ApplicationRecord
	
	def response_time_entries
			wrapper = HarvestApiWrapper.new
			project_id = harvest_project_id
			response_time_entries_raw = wrapper.time_entries(1, project_id)			
				
				#Getting the number of pages of the paginated response from projects API	 
					number_of_pages = response_time_entries_raw['total_pages']
					response_time_entries_per_project = []
				
					if number_of_pages == 1 
						response_time_entries_per_project = response_time_entries_raw.dig('time_entries')
					else 
						#for loop to loop through all the pages and fetch all and put into the variable 	response_time_entries_per_project
						for i in 1..number_of_pages do	
							time_entries_raw = wrapper.time_entries(i, p roject_id)

							next_array = time_entries_raw['time_entries']

							#add projects array to complete array
							response_time_entries_per_project += next_array

						end

				end
		response_time_entries_per_project
	end
	
	def project_data
			wrapper = HarvestApiWrapper.new
				project_id = harvest_project_id

	
			
				total_time = 0
				design = 0
				programming = 0
				meetings = 0
				project_management = 0
			
				response_time_entries.each do |time_entry|		
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
	
			
				
				response_projects = wrapper.project(project_id)
	
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