class DeliveryModality < ApplicationRecord
  validates :mod_name, :mod_price, presence: true
  validates :mod_name, uniqueness: true
  has_many :load_categories
end
