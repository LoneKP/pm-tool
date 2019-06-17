class FetchHarvestProjects
  def initialize(user)
    @user = user
  end


  def harvest_projects
    active_and_billable_projects.map do |project|
      client_name = project.values_at("client").map { |client| client.values_at("name") }.join("")
      project_name = project.values_at("name").join("")
      harvest_project_id = project.values_at("id").join("").to_i
      hours_sold_for = project.values_at("budget").join("").to_f
      project_start_date = project.values_at("created_at").join("").to_datetime
      project_end_date = project.values_at("ends_on").join("").to_datetime

      harvest_projects = Hash.new 
      harvest_projects['harvest_project_id'] = harvest_project_id 
      harvest_projects['client_name'] = client_name
      harvest_projects['project_name'] = project_name
      harvest_projects['hours_sold_for'] = hours_sold_for
      harvest_projects['project_start_date'] = project_start_date
      harvest_projects['project_end_date'] = project_end_date
      
      harvest_projects
    end
  end

  def wrapper(_user)
    @_wrapper ||= HarvestApiWrapper.new(@user)
  end

  def active_and_billable_projects
    @_active_projects ||= all_projects.select { |project| project.dig("is_active") && project.dig("is_billable") }
  end

  def all_projects_page_one_response
    response = wrapper(@user).all_projects(1)
  end

  def projects_page_one
    all_projects_page_one_response.dig("projects")
  end

  def number_of_pages
    all_projects_page_one_response["total_pages"]
  end

  def projects_with_more_pages
    all_projects_when_more_pages = []

    (1..number_of_pages).each do |i|
      all_projects_collected = wrapper(@user).all_projects(i)

      next_array = all_projects_collected["projects"]

      # add projects array to complete array
      all_projects_when_more_pages += next_array
    end
    all_projects_when_more_pages
  end

  def all_projects
    all_projects = if number_of_pages == 1
                     projects_page_one
                   else
                     projects_with_more_pages
                   end
  end
end
