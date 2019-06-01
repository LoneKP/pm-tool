class User < ApplicationRecord
  has_secure_password 
  has_many :responsibilities, dependent: :destroy
  has_many :projects, through: :responsibilities
  has_many :invitations
  belongs_to :organisation, inverse_of: :users, optional: true
  validates_presence_of :organisation

  before_save { self.email = email.downcase }
  validates :first_name, presence: true
  validates :first_name, length: { minimum: 2 }
  validates :first_name, length: { maximum: 25 }
  validates :last_name, presence: true
  validates :last_name, length: { minimum: 2 }
  validates :last_name, length: { maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email,
    presence: true,
    uniqueness: {
      case_sensitive: false,
      message: 'Hey! We know this email already, so it seems that we have met before. Please go to the <a href="%{link}">log in page</a> to log in with this email.',
      link: Rails.application.routes.url_helpers.root_path,
    },
    length: { maximum: 105 },
    format: { with: VALID_EMAIL_REGEX }

  validates :password,
    presence: { message: "You forgot to write a password!" },
    length: {
      minimum: 8,
      message: "This password is too short! Please add a minimum of 8 characters",
      unless: Proc.new { |a| a.password.blank? },
    },
    confirmation: {
      message: "Hmm.. Your password confirmation doesn't match your password. Can you try again?",
      unless: Proc.new { |a| a.password.blank? },
      unless: Proc.new { |a| a.password_confirmation.blank? },
      if: Proc.new { |a| a.password.nil? ? false : a.password.length > 7 },
    }

  validates :password_confirmation,
            presence: {
              message: "You forgot to write a password confirmation! psst... Just write the same password twice",
              unless: Proc.new { |a| a.password.blank? },
              if: Proc.new { |a| a.password.nil? ? false : a.password.length > 7 },
            }
end
