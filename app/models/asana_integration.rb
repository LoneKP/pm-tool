class AsanaIntegration < ApplicationRecord
  belongs_to :organisation

  def type
    "Asana"
  end
end
