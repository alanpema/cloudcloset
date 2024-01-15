class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.date :pick_up
      t.date :drop_off
      t.integer :status
      t.string :final_price
      t.references :user, null: false, foreign_key: true
      t.references :closet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
