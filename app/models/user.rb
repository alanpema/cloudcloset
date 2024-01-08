class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items, dependent: :destroy
  has_many :owner_bookings, class_name: "Booking", dependent: :destroy



  has_many :closets, dependent: :destroy
  has_many :host_bookings, through: :closets, source: :bookings, dependent: :destroy

  def owner?
    role == "owner"
  end
  def host?
    role == "host"
  end
end
