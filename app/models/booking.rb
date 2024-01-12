class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :closet
  has_many :items, dependent: :destroy

  validates :pick_up, :drop_off, presence: true

  enum status: [:payment_pending, :acceptance_pending, :accepted, :rejected, :cancelled]

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


  def ranged_dates
    range = (get_dates_in_range(pick_up_date.strftime('%Y-%m-%d'), drop_off_date.strftime('%Y-%m-%d')).count - 1)
  end
end
