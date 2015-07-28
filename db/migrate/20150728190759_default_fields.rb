class DefaultFields < ActiveRecord::Migration
  def change
    change_column :activities, :max_seats, :integer, default: 100, null: false
    change_column :activities, :min_seats, :integer, default: 1, null: false
    change_column :activities, :cost, :decimal, default: 0, null: false
  end
end
