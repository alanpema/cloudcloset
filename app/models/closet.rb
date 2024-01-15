class Closet < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :closet_reviews, dependent: :destroy

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  has_one_attached :photo

  def not_available
    bookings.map do |booking|
      get_dates_in_range(booking.pick_up_date.strftime('%Y-%m-%d'), booking.drop_off_date.strftime('%Y-%m-%d'))
    end.flatten.join(" ")
  end

  def get_dates_in_range(start_date, end_date)
    require 'date'
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)
    dates = []

    start_date.upto(end_date) do |date|
      dates << date.strftime('%Y-%m-%d')
    end

    dates
  end
end
