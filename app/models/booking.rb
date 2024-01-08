class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :closet
  has_many :items, dependent: :destroy
end
