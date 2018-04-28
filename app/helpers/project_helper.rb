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


	def if_project_is_in_database_grey_out(id)
		if Project.exists?(harvest_project_id: id)
			return ['class="already-on-dashboard"'].join.html_safe
		else
			return ''
		end
	end


	def if_project_is_not_in_database_create_link_to_modal_start(id)
		if Project.exists?(harvest_project_id: id)
			return ''
		else
			return ['<a href="#ex1" rel="modal:open">'].join.html_safe	
		end
	end

	def if_project_is_not_in_database_create_link_to_modal_end(id)
		if Project.exists?(harvest_project_id: id)
			return ''
		else
			return ['</a>'].join.html_safe	
		end
	end
	
	def get_project_id(id)
		return Project.harvest_project_id
	end


end





