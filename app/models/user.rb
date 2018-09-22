class User < ApplicationRecord
	has_many :responsibilities
	has_many :projects, :through => :responsibilities
	before_save {self.email = email.downcase}
	validates :username, presence: true, uniqueness: { case_sensitive: false }
	validates :username, length: { minimum: 2 }
	validates :username, length: { maximum: 25 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 105 }, format: {with: VALID_EMAIL_REGEX }
end