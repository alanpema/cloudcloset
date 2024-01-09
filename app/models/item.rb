class Item < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :booking, dependent: :destroy, optional: true
  validates :name, :item_type, :fragility, :size, presence: true

  ITEM_TYPE = %w(Box Suitcase Sofa Table Chair Bed Desk Bicycle)
  FRAGILITY = %w(Yes No)
  SIZE = %w(Small Medium Large)

  validates :item_type, inclusion: { in: ITEM_TYPE }
  validates :fragility, inclusion: { in: FRAGILITY }
  validates :size, inclusion: { in: SIZE }

end
