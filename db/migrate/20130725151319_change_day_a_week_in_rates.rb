class ChangeDayAWeekInRates < ActiveRecord::Migration
  def up
    remove_column :rates, :day_a_week
    add_column :rates, :start_day_a_week, :integer #Sunday 0, Monday 1, etc...
    add_column :rates, :end_day_a_week, :integer #Sunday 0, Monday 1, etc...
  end

  def down
    add_column :rates, :day_a_week, :integer #Sunday 0, Monday 1, etc...
    remove_column :rates, :start_day_a_week
    remove_column :rates, :end_day_a_week
  end
end
