class DistanceCategory < ApplicationRecord
  belongs_to :delivery_modality
  validates :min_distance, :max_distance, :distance_price, :delivery_time, presence: true
  validates :min_distance, numericality: {greater_than_or_equal_to: 100}
  validates :min_distance, :max_distance, :distance_price, numericality: true
  validates :max_distance, comparison: { greater_than: :min_distance }
  validates :distance_price, :delivery_time, numericality: {greater_than_or_equal_to: 0}
  validates :min_distance, :max_distance, uniqueness: { scope: :delivery_modality_id,
    message: "deve ter distância única por modalidade" }

  def formated_description
    "#{min_distance/1000}km - #{max_distance/1000}km"
  end

end
