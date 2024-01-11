class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :closet
  has_many :items, dependent: :destroy

  enum status: [:payment_pending, :acceptance_pending, :accepted, :rejected, :cancelled]
end
