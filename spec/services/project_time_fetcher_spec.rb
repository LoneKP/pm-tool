require 'rails_helper'
RSpec.describe ProjectTimeFetcher do
  it 'does something' do
    api_wrapper = double('api_wrapper', time_entries: Marshal.load(File.binread('time_entries')))
    project = Project.create!
    ProjectTimeFetcher.new(project, api_wrapper).call
    expect(TimeTracking.count).to eq(7)
    expect(TimeTracking.first.attributes.except('id', 'created_at', 'updated_at')).to eq('date' => Time.parse('2018-04-06 0:0:0Z'),

                                                                                         'project_id' => project.id,
                                                                                         'total_hours' => 0.1,
                                                                                         'total_hours_daily_standup' => nil,
                                                                                         'total_hours_design' => nil,
                                                                                         'total_hours_meetings' => nil,
                                                                                         'total_hours_programming' => nil,
                                                                                         'total_hours_project_management' => 0.1)
  end
end
