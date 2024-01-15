class Item < ApplicationRecord
  belongs_to :user
  belongs_to :booking, dependent: :destroy, optional: true
  validates :name, :item_type, :fragility, :size, :photo, presence: true

  ITEM_TYPE = %w(Box Suitcase Sofa Table Chair Bed Desk Bicycle TV Fridge Washing\ Machine)
  TYPE_PRICES = {
    "Box" => 0.5,
    "Suitcase" => 0.6,
    "Chair" => 0.7,
    "Bicycle" => 0.7,
    "Table" => 0.9,
    "Desk" => 0.9,
    "Sofa" => 1,
    "Bed" => 1,
  }
  FRAGILITY = %w(Yes No)

  SIZE = %w(Small Medium Large)
  SIZE_PRICES = {
    "Small" => 1,
    "Medium" => 1.5,
    "Large" => 2,
  }

  validates :item_type, inclusion: { in: ITEM_TYPE }
  validates :fragility, inclusion: { in: FRAGILITY }
  validates :size, inclusion: { in: SIZE }
  has_one_attached :photo
end
