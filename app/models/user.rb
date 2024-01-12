class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  ROLES = %w(Owner Host)
  validates :role, inclusion: { in: ROLES }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items, dependent: :destroy
  has_many :owner_bookings, class_name: "Booking", dependent: :destroy

  has_one_attached :photo

  has_many :closets, dependent: :destroy
  has_many :host_bookings, through: :closets, source: :bookings, dependent: :destroy

  # Alan.user_reviews
  has_many :received_reviews, foreign_key: :reviewee_id, dependent: :destroy # reviews que ha recibido
  has_many :made_reviews, foreign_key: :reviewer_id, dependent: :destroy # reviews que ha hecho

  has_many :closet_reviews, foreign_key: :reviewer_id, dependent: :destroy # reviews que ha hecho


  def owner?
    role == "Owner"
  end

  def host?
    role == "Host"
  end
end
