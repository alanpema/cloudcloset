class CreateClosets < ActiveRecord::Migration[7.1]
  def change
    create_table :closets do |t|
      t.string :name
      t.string :location
      t.string :features
      t.string :accessibility
      t.string :state
      t.string :availability
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
