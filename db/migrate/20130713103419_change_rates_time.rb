class ChangeRatesTime < ActiveRecord::Migration
  def change
      remove_column :rates, :start_time
      remove_column :rates, :end_time
      add_column :rates, :start_time, :time
      add_column :rates, :end_time, :time
      add_column :rates, :day_a_week, :integer #Sunday 0, Monday 1, etc...
  end
end
