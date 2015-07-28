class DefaultFields2 < ActiveRecord::Migration
  def change
    change_column :activities, :cost, :decimal, precision: 6, scale: 2, default: 0, null: false
  end
end
