class Project < ApplicationRecord
  has_many :risk_actions, inverse_of: :project, autosave: true
  has_many :responsibilities, dependent: :destroy
  has_many :users, through: :responsibilities
  accepts_nested_attributes_for :risk_actions
  has_many :revenue_months, inverse_of: :project, autosave: true
  accepts_nested_attributes_for :revenue_months
  # validates :work_hours, :hours_sold_for, :project_start_date, :project_end_date, presence: true, on: :update
  # validates :work_hours, :hours_sold_for, numericality: true, on: :update

  belongs_to :organisation, inverse_of: :users, optional: true
  validates_presence_of :organisation

  def harvest_integration
    self.organisation.harvest_integration
  end

  def asana_integration
    self.organisation.asana_integration
  end

  def added_to_dashboard?(user)
    projects = user.projects.where(organisation_id: user.organisation.id) 
    current_project = projects.find(self.id)

    if current_project.blank?
      false
    else
      true
    end
  end

  #asana
def has_progress_data?
  !self.progress_percentage.nil?
end

#harvest
def has_time_data?
  !self.completion_percentage.nil?
end

end
