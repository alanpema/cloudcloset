class AddBookingToItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :booking, null: true, foreign_key: true
  end
end
