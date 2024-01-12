class ClosetReview < ApplicationRecord
  belongs_to :closet
  belongs_to :reviewer, class_name: "User"
end
