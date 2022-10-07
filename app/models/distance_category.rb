class DistanceCategory < ApplicationRecord
  belongs_to :delivery_modality

  def formated_description
    "#{min_distance/1000}km - #{max_distance/1000}km"
  end
end
