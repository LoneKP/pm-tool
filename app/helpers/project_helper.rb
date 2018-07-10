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


	def if_project_is_added_to_dashboard_grey_out(id)
		if Project.exists?(harvest_project_id: id, added_to_dashboard:true) or Project.exists?(harvest_project_id: id, archived:true)
			return ['class="already-on-dashboard"'].join.html_safe
		else
			return ''
		end
	end

	def project_is_already_on_dashboard?(id)
		if Project.exists?(harvest_project_id: id, added_to_dashboard:true) or Project.exists?(harvest_project_id: id, archived:true)
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

	
	
	

end





