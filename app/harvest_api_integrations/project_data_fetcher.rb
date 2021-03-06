class ProjectDataFetcher
  def initialize(project, user)
    @project = project
    @user = user
  end

  def call
    @project.project_name = project_name
    @project.client_name = client_name
    #    @project.hours_sold_for = hours_sold_for
    @project.total_time_hours = total_billable_time_entries
    @project.programming_hours = programming_hours
    @project.project_management_hours = project_management_hours
    @project.meetings_hours = meetings_hours
    @project.design_hours = design_hours
    @project.completion_percentage = completion_percentage
    #    @project.project_start_date = project_start_date
    @project.project_end_date = project_end_date
    @project.color_number = color_number
    @project.organisation_id = @user.organisation_id
    @project.save
  end

  #  private

  #  def response_time_entries
  #    response_time_entries_per_project = []
  #
  #    loop.with_index(1) do |_,index|
  #      response = wrapper.time_entries(index, harvest_project_id)
  #      response_time_entries_per_project << response['time_entries']
  #
  #      break if response['page'] == response['total_pages']
  #    end
  #
  #    response_time_entries_per_project
  #  end

  def response_time_entries
    response_time_entries_raw = wrapper(@user).time_entries(1, harvest_project_id)

    # Getting the number of pages of the paginated response from projects API
    number_of_pages = response_time_entries_raw['total_pages']

    response_time_entries_per_project = []

    if number_of_pages == 1
      response_time_entries_per_project = response_time_entries_raw.dig('time_entries')
    else
      # for loop to loop through all the pages and fetch all and put into the variable response_time_entries_per_project

      (1..number_of_pages).each do |i|
        time_entries_raw = wrapper(@user).time_entries(i, harvest_project_id)

        next_array = time_entries_raw['time_entries']

        # add projects array to complete array
        response_time_entries_per_project += next_array
      end

    end
    response_time_entries_per_project
  end

  def wrapper(_user)
    @_wrapper ||= HarvestApiWrapper.new(@user)
  end

  def harvest_project_id
    @project.harvest_project_id
  end

  def color_number
    #    rand(1..8)
    1
  end

  def billable_time_entries
    @_billable_time_entries ||= response_time_entries.select { |time_entry| time_entry.dig('billable') }
  end

  def total_billable_time_entries
    @_total_billable_time_entries ||= billable_time_entries.sum { |time_entry| time_entry.dig('hours') }
  end

  def project_start_date
    billable_time_entries[-1]['created_at']
  end

  def project_end_date
    @project.project_end_date
    #    response_projects.dig('ends_on') == nil ? project_end_date_calc : response_projects.dig('ends_on')
  end

  def weekdays_required_to_finish
    ((hours_sold_for - total_billable_time_entries) / 6).ceil
  end

  #  def project_end_date_calc
  #    weekdays_required_to_finish > 0 ? weekdays_required_to_finish.business_days.from_now : Time.first_business_day(Time.current)
  #  end

  def design_billable_time_entries
    @_design_billable_time_entries ||= billable_time_entries.select { |time_entry| time_entry.dig('task', 'name') == 'Design' }
  end

  def design_hours
    @_design_hours ||= design_billable_time_entries.sum { |time_entry| time_entry.dig('hours') }
  end

  def billable_design_time_entries_over_time
    (design_billable_time_entries.map { |time_entry| time_entry.values_at('spent_date', 'hours') }).reverse.to_h
  end

  def programming_billable_time_entries
    @_programming_billable_time_entries ||=  billable_time_entries.select { |time_entry| time_entry.dig('task', 'name') == 'Programming' }
  end

  def programming_hours
    @_programming_hours ||= programming_billable_time_entries.sum { |time_entry| time_entry.dig('hours') }
  end

  def billable_programming_time_entries_over_time
    (programming_billable_time_entries.map { |time_entry| time_entry.values_at('spent_date', 'hours') }).reverse.to_h
  end

  def project_management_billable_time_entries
    @_project_management_billable_time_entries ||= billable_time_entries.select { |time_entry| time_entry.dig('task', 'name') == 'Project Management' }
  end

  def project_management_hours
    @_project_management_hours ||= project_management_billable_time_entries.sum { |time_entry| time_entry.dig('hours') }
  end

  def meetings_billable_time_entries
    @_meetings_billable_time_entries ||= billable_time_entries.select { |time_entry| time_entry.dig('task', 'name') == 'Meeting' }
  end

  def meetings_hours
    @_meetings_hours ||= meetings_billable_time_entries.sum { |time_entry| time_entry.dig('hours') }
  end

  def response_projects
    wrapper(@user).project(harvest_project_id)
  end

  #  def hours_sold_for
  #    if response_projects.dig('budget') != nil
  #      response_projects.dig('budget')
  #    else
  #      1
  #    end
  #    #prompt user to input hours_sold_for if it is nil here
  #  end

  def hours_sold_for
    @project.hours_sold_for
  end

  def work_hours
    @project.work_hours
  end

  def project_name
    response_projects.dig('name')
  end

  def client_name
    response_projects.dig('client', 'name')
  end

  def completion_percentage
    !work_hours.nil? ? (total_billable_time_entries / work_hours) * 100 : nil
  end
end
