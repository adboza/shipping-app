class Quotation < ApplicationRecord
  belongs_to :delivery_modality
  belongs_to :service_order
  belongs_to :load_category
  belongs_to :distance_category

  def full_description
    "#{delivery_modality.mod_name}"
  end
end