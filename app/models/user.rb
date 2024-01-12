class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  ROLES = %w(Owner Host)
  validates :role, inclusion: { in: ROLES }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items, dependent: :destroy
  has_many :owner_bookings, class_name: "Booking", dependent: :destroy
  has_many :bookings, dependent: :destroy

  has_one_attached :photo

  has_many :closets, dependent: :destroy
  has_many :host_bookings, through: :closets, source: :bookings, dependent: :destroy

  def owner?
    role == "Owner"
  end

  def host?
    role == "Host"
  end

  def not_booked_items
    items.select do |item|
      item.booking.nil?
    end
  end
end
