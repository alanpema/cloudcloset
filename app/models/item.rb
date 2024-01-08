class Item < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :booking, dependent: :destroy
end
