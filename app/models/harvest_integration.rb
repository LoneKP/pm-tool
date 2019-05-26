class HarvestIntegration < ApplicationRecord
  belongs_to :organisation

def type
  'Harvest'
end

end
