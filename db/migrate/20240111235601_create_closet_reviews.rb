class CreateClosetReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :closet_reviews do |t|
      t.string :comment
      t.integer :rating
      t.references :closet, null: false, foreign_key: true
      t.references :reviewer, null: false, foreign_key: { to_table: :users } # usuario que realiza la revisión

      t.timestamps
    end
  end
end
