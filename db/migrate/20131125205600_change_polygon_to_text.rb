class ChangePolygonToText < ActiveRecord::Migration
  def up
    change_column :areas, :polygon, :text
  end
  def down
    # This might cause trouble if you have strings longer
    # than 255 characters.
    change_column :areas, :polygon, :string
  end
end
