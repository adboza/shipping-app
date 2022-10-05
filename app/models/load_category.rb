class LoadCategory < ApplicationRecord
  validates :min_weight, :max_weight, presence: true
  belongs_to :delivery_modality
  def formated_description
    "#{min_weight}kg - #{max_weight}kg"
  end
  def formated_value 
    "R$#{weight_price}"
  end
end
