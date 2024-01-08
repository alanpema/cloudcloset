class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :type
      t.string :fragility
      t.string :state
      t.string :size
      t.string :sell_price
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
