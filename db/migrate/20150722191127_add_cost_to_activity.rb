class AddCostToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :cost, :decimal, precision: 6, scale: 2
  end
end
