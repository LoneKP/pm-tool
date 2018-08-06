class Project < ApplicationRecord
	has_many :risk_actions, inverse_of: :project, autosave: true
	accepts_nested_attributes_for :risk_actions
	has_many :revenue_months, inverse_of: :project, autosave: true
	accepts_nested_attributes_for :revenue_months
	validates :work_hours, :hours_sold_for, :project_start_date, :project_end_date, presence: true, on: :update
	validates :work_hours, :hours_sold_for, numericality: true, on: :update
end



