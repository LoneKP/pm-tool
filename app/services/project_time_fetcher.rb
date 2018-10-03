class ProjectTimeFetcher

	def initialize(project, api_wrapper = nil)
		@_wrapper = api_wrapper
		@project = project
	end

	def call
		TimeTracking.delete_all
		combine_all_hours.each do |date, hours|
			entry = TimeTracking.new
			entry.project_id = @project.id
			entry.date = date
			entry.total_hours_design = hours.dig("design_hours")
			entry.total_hours_programming = hours.dig("programming_hours")
			entry.total_hours_project_management = hours.dig("project_management_hours")
			entry.total_hours_meetings = hours.dig("meetings_hours")
			entry.total_hours_daily_standup = hours.dig("daily_standup_hours")
			entry.total_hours = hours.dig("total_billable_hours")
			entry.save
		end
	end

	#	private

	def response_time_entries
		response_time_entries_raw = wrapper.time_entries(1, harvest_project_id)			

		#Getting the number of pages of the paginated response from projects API	 
		number_of_pages = response_time_entries_raw['total_pages']

		response_time_entries_per_project = []

		if number_of_pages == 1 
			response_time_entries_per_project = response_time_entries_raw.dig('time_entries')
		else 
			#for loop to loop through all the pages and fetch all and put into the variable response_time_entries_per_project

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

	def billable_time_entries_grouped_by_date
		billable_time_entries.group_by { |time_entry| time_entry["spent_date"]}
	end

	def billable_time_entries_hours_per_day
		billable_time_entries_grouped_by_date.values.map {|array| array.map {|entry| entry.dig('hours')}}
	end

	def total_hours_billable
		(billable_time_entries_hours_per_day.map {|a| a.sum }).each_slice(1).to_a
	end

	def billable_time_entries_date
		billable_time_entries_grouped_by_date.values.map {|array| array.map {|entry| entry.dig('spent_date')}.uniq}
	end

	def billable_hours_per_date
		Hash[billable_time_entries_date.flatten.zip total_hours_billable.flatten]
	end

	def billable_hours
		billable_hours_per_date.update(billable_hours_per_date) { |k,v| billable_hours_per_date[k]=Hash["total_billable_hours",v] }
	end

	#design part

	def design_billable_time_entries
		@_design_billable_time_entries ||= billable_time_entries.select { |time_entry| time_entry.dig('task', 'name') == 'Design' }
	end

	def design_billable_time_entries_grouped_by_date
		design_billable_time_entries.group_by { |time_entry| time_entry["spent_date"]}
	end

	def design_billable_time_entries_hours_per_day
		design_billable_time_entries_grouped_by_date.values.map {|array| array.map {|entry| entry.dig('hours')}}
	end

	def total_hours_design
		(design_billable_time_entries_hours_per_day.map {|a| a.sum }).each_slice(1).to_a
	end

	def design_billable_time_entries_date
		design_billable_time_entries_grouped_by_date.values.map {|array| array.map {|entry| entry.dig('spent_date')}.uniq}
	end

	def design_hours_per_date
		Hash[design_billable_time_entries_date.flatten.zip total_hours_design.flatten]
	end

	def design_hours
		design_hours_per_date.update(design_hours_per_date) { |k,v| design_hours_per_date[k]=Hash["design_hours",v] }
	end

	#programming part

	def programming_billable_time_entries
		@_programming_billable_time_entries ||=	billable_time_entries.select { |time_entry| time_entry.dig('task', 'name') == 'Programming' }
	end

	def programming_billable_time_entries_grouped_by_date
		programming_billable_time_entries.group_by { |time_entry| time_entry["spent_date"]}
	end

	def programming_billable_time_entries_hours_per_day
		programming_billable_time_entries_grouped_by_date.values.map {|array| array.map {|entry| entry.dig('hours')}}
	end

	def total_hours_programming
		(programming_billable_time_entries_hours_per_day.map {|a| a.sum }).each_slice(1).to_a
	end

	def programming_billable_time_entries_date
		programming_billable_time_entries_grouped_by_date.values.map {|array| array.map {|entry| entry.dig('spent_date')}.uniq}
	end

	def programming_hours_per_date
		Hash[programming_billable_time_entries_date.flatten.zip total_hours_programming.flatten]
	end

	def programming_hours
		programming_hours_per_date.update(programming_hours_per_date) { |k,v| programming_hours_per_date[k]=Hash["programming_hours",v] }
	end

	#project management part

	def project_management_billable_time_entries
		@_project_management_billable_time_entries ||= billable_time_entries.select { |time_entry| time_entry.dig('task', 'name') == 'Project Management' }
	end

	def project_management_billable_time_entries_grouped_by_date
		project_management_billable_time_entries.group_by { |time_entry| time_entry["spent_date"]}
	end

	def project_management_billable_time_entries_hours_per_day
		project_management_billable_time_entries_grouped_by_date.values.map {|array| array.map {|entry| entry.dig('hours')}}
	end

	def total_hours_project_management
		(project_management_billable_time_entries_hours_per_day.map {|a| a.sum }).each_slice(1).to_a
	end

	def project_management_billable_time_entries_date
		project_management_billable_time_entries_grouped_by_date.values.map {|array| array.map {|entry| entry.dig('spent_date')}.uniq}
	end

	def project_management_hours_per_date
		Hash[project_management_billable_time_entries_date.flatten.zip total_hours_project_management.flatten]
	end

	def project_management_hours
		project_management_hours_per_date.update(project_management_hours_per_date) { |k,v| project_management_hours_per_date[k]=Hash["project_management_hours",v] }
	end

	#meetings part

	def meetings_billable_time_entries
		@_meetings_billable_time_entries ||= billable_time_entries.select { |time_entry| time_entry.dig('task', 'name') == 'Meeting' }
	end

	def meetings_billable_time_entries_grouped_by_date
		meetings_billable_time_entries.group_by { |time_entry| time_entry["spent_date"]}
	end

	def meetings_billable_time_entries_hours_per_day
		meetings_billable_time_entries_grouped_by_date.values.map {|array| array.map {|entry| entry.dig('hours')}}
	end

	def total_hours_meetings
		(meetings_billable_time_entries_hours_per_day.map {|a| a.sum }).each_slice(1).to_a
	end

	def meetings_billable_time_entries_date
		meetings_billable_time_entries_grouped_by_date.values.map {|array| array.map {|entry| entry.dig('spent_date')}.uniq}
	end

	def meetings_hours_per_date
		Hash[meetings_billable_time_entries_date.flatten.zip total_hours_meetings.flatten]
	end

	def meetings_hours
		meetings_hours_per_date.update(meetings_hours_per_date) { |k,v| meetings_hours_per_date[k]=Hash["meetings_hours",v] }
	end
	
	#daily standup part

	def daily_standup_time_entries
		@_daily_standup_time_entries ||= billable_time_entries.select { |time_entry| time_entry.dig('task', 'id') == 9701231 }
	end

	def daily_standup_billable_time_entries_grouped_by_date
		daily_standup_time_entries.group_by { |time_entry| time_entry["spent_date"]}
	end

	def daily_standup_billable_time_entries_hours_per_day
		daily_standup_billable_time_entries_grouped_by_date.values.map {|array| array.map {|entry| entry.dig('hours')}}
	end

	def total_hours_daily_standup
		(daily_standup_billable_time_entries_hours_per_day.map {|a| a.sum }).each_slice(1).to_a
	end

	def daily_standup_billable_time_entries_date
		daily_standup_billable_time_entries_grouped_by_date.values.map {|array| array.map {|entry| entry.dig('spent_date')}.uniq}
	end

	def daily_standup_hours_per_date
		Hash[daily_standup_billable_time_entries_date.flatten.zip total_hours_daily_standup.flatten]
	end

	def daily_standup_hours
		daily_standup_hours_per_date.update(daily_standup_hours_per_date) { |k,v| daily_standup_hours_per_date[k]=Hash["daily_standup_hours",v] }
	end

	#combine
	def combine_project_management_and_meetings_hours
		project_management_hours.merge(meetings_hours){|key,oldval,newval| oldval.merge(newval) }
	end

	def combine_design_hours_and_programming_hours
		design_hours.merge(programming_hours){|key,oldval,newval| oldval.merge(newval) }
	end

	def combine_all_task_hours
		combine_design_hours_and_programming_hours.merge(combine_project_management_and_meetings_hours){|key,oldval,newval| oldval.merge(newval) }
	end

	def combine_with_billable_hours
		combine_all_task_hours.merge(billable_hours){|key,oldval,newval| oldval.merge(newval) }
	end
	
	def combine_all_hours
		combine_with_billable_hours.merge(daily_standup_hours){|key,oldval,newval| oldval.merge(newval) }
	end

end


