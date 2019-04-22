class Invitation < ApplicationRecord
  before_create :generate_token

  belongs_to :user
  belongs_to :organisation

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.organisation_id, Time.now, rand].join)
  end
end
