module ProjectHelper

	def completion_indicator(project)
		content_tag('div', class:'d-flex flex-row my-75 align-items-center') do
			if project.completion_percentage >= 97 && project.completion_percentage <= 103 
				[content_tag('div', '', class:'on-track-indicator'), 
					content_tag('p', 'Hours reached', class:'on-track')].join.html_safe
			elsif project.completion_percentage <= 100
				[content_tag('div', '', class:'on-track-indicator'), 
					content_tag('p', 'On track', class:'on-track')].join.html_safe
			else
				[content_tag('div', '', class:'not-on-track-indicator',), 
					content_tag('p', 'Over time', class:'on-track')].join.html_safe
			end
		end
	end


	def if_project_is_added_to_dashboard_grey_out(id, user)
		if user.projects.exists?(harvest_project_id: id) or user.projects.exists?(harvest_project_id: id, archived:true)
			return ['class="already-on-dashboard"'].join.html_safe
		else
			return ''
		end
	end

	def project_is_already_on_dashboard?(id, user)
		if user.projects.exists?(harvest_project_id: id) or user.projects.exists?(harvest_project_id: id, archived:true)
			return true
		else
			return false
		end
	end

	def project_in_need_of_risk_update?(project)
		today = Time.now.to_date
		last_risk_update = (RiskAction.where(project_id:project.id).last&.created_at)&.to_date 
		if last_risk_update.present?
			days_since_last_risk_update = (today - last_risk_update).to_i
			if days_since_last_risk_update < 6 
				false
			else
				true
			end 
		else
			true
		end
	end

	def calculate_day_progression(project)
		start_date = project.project_start_date.to_date
		end_date = project.project_end_date.to_date
		total_days = (end_date - start_date).to_i
		today = Time.now.to_date
		progressed_days = (today - start_date).to_f
		progressed_days_percentage = (progressed_days / total_days)*100

		if progressed_days > total_days
			#end date has been passed
			100
		elsif progressed_days == total_days
			#this is the end date
			100
		else
			progressed_days_percentage
		end
	end





end





