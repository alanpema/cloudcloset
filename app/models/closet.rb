class Closet < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :bookings, dependent: :destroy
end
