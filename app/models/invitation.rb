class Invitation < ApplicationRecord
  before_create :generate_token

  belongs_to :user
  belongs_to :organisation

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email,
    uniqueness: {
      case_sensitive: false,
      message: "Hey! It seems like your colleague is already signed up!",
    },
    length: { maximum: 105 },
    format: { with: VALID_EMAIL_REGEX },
    allow_blank: true

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.organisation_id, Time.now, rand].join)
  end
end
