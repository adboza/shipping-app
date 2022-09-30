class LoadCategory < ApplicationRecord
  validates :min_weight, :max_weight, :weight_dist_price, presence: true
  
  def formated_description
    "#{min_weight}kg - #{max_weight}kg"
  end
  def formated_value 
    "#{weight_dist_price}"
  end
end
