class AllProjectsFetcher
	
		def wrapper
			@_wrapper ||= HarvestApiWrapper.new
		end
	
		def all_projects_page_one_response
			wrapper.all_projects(1)
		end
	
		def projects_page_one
			all_projects_page_one_response.dig('projects')
		end
	
		def number_of_pages
			all_projects_page_one_response['total_pages']
		end
	
		def projects_with_more_pages
			
			all_projects_when_more_pages = []
			
			for i in 1..number_of_pages do	
					all_projects_collected = wrapper.all_projects(i)

					next_array = all_projects_collected['projects']

					#add projects array to complete array
					all_projects_when_more_pages += next_array
			end
			all_projects_when_more_pages
		end
		
		def all_projects
			if number_of_pages == 1
				all_projects = projects_page_one
			else
				all_projects = projects_with_more_pages
			end
		end
	
		def active_and_billable_projects
			@_active_projects ||= all_projects.select { |project| project.dig('is_active') && project.dig('is_billable') }
		end
	
		

	
end


