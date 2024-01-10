class Closet < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :bookings, dependent: :destroy

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
