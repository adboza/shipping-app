class DeliveryModality < ApplicationRecord
  validates :mod_name, :mod_price, presence: true
  validates :mod_name, uniqueness: true
  has_many :load_categories
  has_many :distance_categories
  has_many :vehicle_type_selection
  has_many :vehicle_types, through: :vehicle_type_selection

  def available_modalities
    delivery_modalities = DeliveryModality.all
    available_modalities = []
    delivery_modalities.each do |modality|
      available_modalities << {delivery_modality_id: modality.id, modality_name: modality.mod_name, modality_price: modality.mod_price}
    end
    available_modalities
  end
end
