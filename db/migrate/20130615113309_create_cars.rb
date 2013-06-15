class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.references :user
      t.string :license_plate
      t.string :car_description
      t.attachment :car_image

      t.timestamps
    end
    add_index :cars, :user_id
  end
end
