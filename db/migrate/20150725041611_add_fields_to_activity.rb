class AddFieldsToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :min_seats, :integer
    add_column :activities, :cash_only, :boolean
    rename_column :activities, :seats, :max_seats
  end
end
