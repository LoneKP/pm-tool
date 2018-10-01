class Responsibility < ApplicationRecord
	belongs_to :project
	belongs_to :user
#	validates :project_id, uniqueness: true
end