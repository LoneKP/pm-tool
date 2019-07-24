  class MarkedAsDone
    def initialize(user, project)
      @user = user
      @project = project
    end

    def save_progress_data
      @project.update(
      progress_percentage: progress_percentage,
      done_tasks_count: done_tasks_count,
      all_tasks_count: all_tasks_count,
      )
    end

    def progress_percentage
      @_progress_percentage ||= (done_tasks_count.to_f / all_tasks_count.to_f) * 100
    end

    def all_tasks
      @_all_tasks||= wrapper(@user).tasks(@project.asana_project_id)
    end

    def all_tasks_count
      @_all_tasks_count ||= all_tasks.count
    end

    def done_tasks_count
      all_tasks.map do |task|
        wrapper(@user).task(task["gid"])
      end.select { |t| t["completed"] == true }.count
      # @_done_tasks_count ||= all_taskx.select { |t| t["completed"] == true }.count
    end

    def wrapper(_user)
      @_wrapper ||= AsanaApiWrapper.new(@user)
    end
  end

