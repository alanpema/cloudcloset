class AddCoordinatesToClosets < ActiveRecord::Migration[7.1]
  def change
    add_column :closets, :latitude, :float
    add_column :closets, :longitude, :float
  end
end
