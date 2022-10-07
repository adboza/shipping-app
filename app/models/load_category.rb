class LoadCategory < ApplicationRecord
  validates :min_weight, :max_weight, presence: true
  validates :min_weight, :max_weight, :weight_price, numericality: {greater_than_or_equal_to: 0}
  validates :max_weight, comparison: { greater_than: :min_weight }
  validates :min_weight,:max_weight, uniqueness: true
  belongs_to :delivery_modality
  
  def formated_description
    "#{min_weight}kg - #{max_weight}kg"
  end
end
