class ProjectDataFetcher
	def initialize(project)
		@project = project
	end
	
	def call
		@project.project_name = project_name
		@project.client_name = client_name
		@project.hours_sold_for = hours_sold_for
		@project.total_time_hours = total_billable_time_entries
		@project.programming_hours = programming_hours
		@project.project_management_hours = project_management_hours
		@project.meetings_hours = meetings_hours
		@project.design_hours = design_hours
		@project.completion_percentage = completion_percentage
		@project.save
	end
	
	private
	
	def response_time_entries
		response_time_entries_raw = wrapper.time_entries(1, harvest_project_id)			
				
		#Getting the number of pages of the paginated response from projects API	 
		number_of_pages = response_time_entries_raw['total_pages']
		
		response_time_entries_per_project = []
				
		if number_of_pages == 1 
			response_time_entries_per_project = response_time_entries_raw.dig('time_entries')
		else 
		#for loop to loop through all the pages and fetch all and put into the variable 	response_time_entries_per_project
		
			for i in 1..number_of_pages do	
				time_entries_raw = wrapper.time_entries(i, harvest_project_id)

				next_array = time_entries_raw['time_entries']

				#add projects array to complete array
				response_time_entries_per_project += next_array

			end

		end
		response_time_entries_per_project
		end
	
		def wrapper
			@_wrapper ||= HarvestApiWrapper.new
		end

		def harvest_project_id
			@project.harvest_project_id
		end

		def billable_time_entries
			@_billable_time_entries ||= response_time_entries.select { |time_entry| time_entry.dig('billable') }
		end
	
		def total_billable_time_entries
			@_total_billable_time_entries ||= billable_time_entries.sum { |time_entry| time_entry.dig('hours') }
		end

		def design_billable_time_entries
			@_design_billable_time_entries ||=	billable_time_entries.select { |time_entry| time_entry.dig('task', 'name') == 'Design' }
		end

		def design_hours
			@_design_hours ||= design_billable_time_entries.sum { |time_entry| time_entry.dig('hours') }
		end

		def programming_billable_time_entries
			@_programming_billable_time_entries ||=	billable_time_entries.select { |time_entry| time_entry.dig('task', 'name') == 'Programming' }
		end

		def programming_hours
			@_programming_hours ||= programming_billable_time_entries.sum { |time_entry| time_entry.dig('hours') }
		end

		def project_management_billable_time_entries
			@_project_management_billable_time_entries ||=	billable_time_entries.select { |time_entry| time_entry.dig('task', 'name') == 'Project Management' }
		end

		def project_management_hours
			@_project_management_hours ||= project_management_billable_time_entries.sum { |time_entry| time_entry.dig('hours') }
		end

		def meetings_billable_time_entries
			@_meetings_billable_time_entries ||=	billable_time_entries.select { |time_entry| time_entry.dig('task', 'name') == 'Meeting' }
		end

		def meetings_hours
			@_project_management_hours ||= meetings_billable_time_entries.sum { |time_entry| time_entry.dig('hours') }
		end

		def response_projects
			wrapper.project(harvest_project_id)
		end

		def hours_sold_for
			response_projects.dig('budget')
		end

		def project_name
			response_projects.dig('name')
		end

		def client_name
			response_projects.dig('client', 'name')
		end

		def completion_percentage
			(total_billable_time_entries / hours_sold_for) * 100
		end

	
	def project_data
		@_project_data ||= begin

				total_time = 0
				design = 0
				programming = 0
				meetings = 0
				project_management = 0
			
				response_time_entries.each do |time_entry|		
					#set time_per_entry and filter out non-billable time entries
					
					time_per_entry = time_entry.dig('billable') ? time_entry.dig('hours') : 0

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
				
				response_projects = wrapper.project(harvest_project_id)
	
					hours_sold_for = response_projects.dig('budget')	
					project_name = response_projects.dig('name')
					client = response_projects.dig('client', 'name')
					percentage = (total_time / hours_sold_for) * 100 			

				{
					"project_id" => harvest_project_id,
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

end
