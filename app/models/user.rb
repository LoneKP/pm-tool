class User < ApplicationRecord
	has_many :responsibilities, dependent: :destroy
	has_many :projects, :through => :responsibilities
	before_save {self.email = email.downcase}
	validates :first_name, presence: true
	validates :first_name, length: { minimum: 2 }
	validates :first_name, length: { maximum: 25 }
	validates :last_name, presence: true
	validates :last_name, length: { minimum: 2 }
	validates :last_name, length: { maximum: 25 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 105 }, format: {with: VALID_EMAIL_REGEX }

	belongs_to :organization, inverse_of: :users, optional: true
	validates_presence_of :organization
end