class DistanceCategory < ApplicationRecord
  belongs_to :delivery_modality
  validates :min_distance, :max_distance, :distance_price, presence: true

  def formated_description
    "#{min_distance/1000}km - #{max_distance/1000}km"
  end
end
