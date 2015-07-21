class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.string :instructor
      t.string :description
      t.date :start
      t.date :end
      t.string :times
      t.integer :seats
      t.boolean :visible
      t.date :lakewood_eligibility_date

      t.timestamps null: false
    end
  end
end
