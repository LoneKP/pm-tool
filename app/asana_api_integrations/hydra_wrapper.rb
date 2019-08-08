class HydraWrapper
  def initialize(user, project)
    @user = user
    @project = project
  end

  def all_tasks(project_id)
    request = tasks(project_id)
  end

  def done_tasks_count
    all_tasks.map do |task|
      wrapper(@user).task(task["gid"])
    end.select { |t| t["completed"] == true }.count
  end

  def tasks(project)
    hydra = Typhoeus::Hydra.hydra
    request1 = Typhoeus::Request.new(
      "https://app.asana.com/api/1.0/projects/#{project.asana_project_id}/tasks",
      headers: headers(
        "https://app.asana.com/api/1.0/projects/#{project.asana_project_id}/tasks"
      ),
    )

    hydra.queue(request1)
    hydra.run
    response = JSON.parse(request1.response.body).dig("data")

    requests = response.map do |task|
      request2 = task(task["gid"])
      request2.run
      JSON.parse(request2.response.body).dig("data")
    end

    requests.select { |t| t["completed"] == true }.count

  end

  def task(task_id)
    request2 = Typhoeus::Request.new(
      "https://app.asana.com/api/1.0/tasks/#{task_id}",
      headers: headers(
        "https://app.asana.com/api/1.0/tasks/#{task_id}"
      ),
    )
  end

  def headers(agent)
    {
      "Authorization" => @user.organisation.asana_integration.access_token,
    }
  end
end
