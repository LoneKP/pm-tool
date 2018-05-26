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
		if Project.exists?(harvest_project_id: id, added_to_dashboard:true)
			return ['class="already-on-dashboard"'].join.html_safe
		else
			return ''
		end
	end

	def project_is_already_on_dashboard?(id)
		if Project.exists?(harvest_project_id: id, added_to_dashboard:true)
			return true
		else
			return false
		end
	end

end





