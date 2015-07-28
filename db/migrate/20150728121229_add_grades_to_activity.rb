class AddGradesToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :min_grade, :integer, default: 0, null: false
    add_column :activities, :max_grade, :integer, default: 5, null: false
  end
end
