class AddPolygonToArea < ActiveRecord::Migration
  def change
    add_column :areas, :polygon, :string
  end
end
