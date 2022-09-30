class LoadCategory < ApplicationRecord
  validates :min_weight, :max_weight, presence: true
  
  def formated_description
    "#{min_weight}kg - #{max_weight}kg"
  end
  def formated_value 
    "#{}"
  end
end
