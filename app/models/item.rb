class Item < ApplicationRecord
  attr_accessor :multiple

  belongs_to :user
  belongs_to :booking, dependent: :destroy, optional: true
  validates :name, :item_type, :fragility, :size, :photo, presence: true

  ITEM_TYPE = %w(Box Suitcase Sofa Table Chair Bed Desk Bicycle Screen Instrument)
  TYPE_PRICES = {
    "Box" => 0.5,
    "Suitcase" => 0.6,
    "Instrument" => 0.6,
    "Screen" => 0.7,
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
