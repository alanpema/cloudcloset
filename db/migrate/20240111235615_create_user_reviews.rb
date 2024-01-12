class CreateUserReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :user_reviews do |t|
      t.string :comment
      t.integer :rating
      t.references :reviewer, null: false, foreign_key: { to_table: :users } # usuario que realiza la revisión
      t.references :reviewee, null: false, foreign_key: { to_table: :users } # usuario que está siendo revisado

      t.timestamps
    end
  end
end
