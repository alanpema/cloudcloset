class Item < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :booking, dependent: :destroy, optional: true
  validates :name, :item_type, :fragility, :size, :photo, presence: true

  ITEM_TYPE = %w(Box Suitcase Sofa Table Chair Bed Desk Bicycle TV Fridge Washing\ Machine)
  ITEM_TYPE_PRICES = {
    "Box" => 5,
    "Suitcase" => 10,
    "Sofa" => 20,
    "Table" => 20,
    "Chair" => 10,
    "Bed" => 30,
    "Desk" => 20,
    "Bicycle" => 20,
  }
  FRAGILITY = %w(Yes No)
  SIZE = %w(Small Medium Large)
  SIZE_PRICES = {
    "Small" => 0.5,
    "Medium" => 1,
    "Large" => 2
  }

  validates :item_type, inclusion: { in: ITEM_TYPE }
  validates :fragility, inclusion: { in: FRAGILITY }
  validates :size, inclusion: { in: SIZE }
  has_one_attached :photo
end
