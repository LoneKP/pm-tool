class TimeTracking < ApplicationRecord
  belongs_to :project
  validates_presence_of :project
end

# , inverse_of: :time_trackings, optional: true
