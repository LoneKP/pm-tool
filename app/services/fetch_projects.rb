class FetchProjects


	test = [ {"a"=>1,"b"=>2,"client"=> {"d" =>3, "e"=>4, "f"=>5}}, {"a"=>1,"b"=>2,"client"=> {"d" =>3, "e"=>4, "f"=>5}}, {"a"=>1,"b"=>2,"client"=> {"d" =>3, "e"=>4, "f"=>5}}]


	#		def client_name
	#			hello = active_and_billable_projects.map { |project| project.map.select { |k,v|  k=='name' } }
	#		
	#		end

	#	def client_name
	#		active_and_billable_projects.map { |project| project.values_at('name')   }
	#	end

	def client_name
		active_and_billable_projects.map { |project| project.values_at('client').map {|client| client.values_at('name')}   }
	end

	#	def client_name
	#		active_and_billable_projects.each do |projects|
	#			projects.select do |key, name|
	#				key=='name'
	#			end
	#		end
	#	end



	def project_name
	end

	def harvest_project_id
	end

	def work_hours
	end

	def sold_hours
	end


	def update_projects
		Project.delete_all
		active_and_billable_projects.map do |project| 
			client_name = project.values_at('client').map {|client| client.values_at('name')}.join('')
			project_name = project.values_at('name').join('')
			harvest_project_id = project.values_at('id').join('')
			hours_sold_for = project.values_at('budget').join('')
			UnaddedProject.create(
				client_name: client_name,
				project_name: project_name,
				harvest_project_id: harvest_project_id,	
				hours_sold_for: hours_sold_for,
				added_to_dashboard: false;
				)
		end
	end

	def wrapper
		@_wrapper ||= HarvestApiWrapper.new
	end

	def active_and_billable_projects
		@_active_projects ||= all_projects.select { |project| project.dig('is_active') && project.dig('is_billable') }
	end

	def projects_grouped_by_client
		active_and_billable_projects.group_by {|project| project.dig('client','name') }
	end

	def sort_projects
		projects_grouped_by_client.sort_by{ |key, value| key.downcase }
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

end