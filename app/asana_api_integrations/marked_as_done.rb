class MarkedAsDone
  def initialize(user, project)
    @user = user
    @project = project
  end

  def project_status_percentage
    @_project_status_percentage ||= (done_tasks_in_project.to_f/number_of_tasks_in_project.to_f)*100
  end

  def all_tasks_in_project
    @_all_tasks_in_project ||= FetchAsanaProjects.new(@user).tasks(@project.asana_project_id).parsed_response["data"]
  end

  def number_of_tasks_in_project
    @_number_of_tasks_in_project ||= all_tasks_in_project.count
  end

  def done_tasks_in_project
    all_tasks = all_tasks_in_project.map do |task|
      FetchAsanaProjects.new(@user).get_task(task["gid"])
    end
    @_done_tasks_in_project ||= all_tasks.select { |t| t["data"]["completed"] == true }.count
  end

end
