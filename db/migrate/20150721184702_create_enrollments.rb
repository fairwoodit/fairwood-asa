class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.belongs_to :activity, index: true, foreign_key: true
      t.belongs_to :student, index: true, foreign_key: true
      t.boolean :low_income
      t.boolean :committed
      t.boolean :paid

      t.timestamps null: false
    end
  end
end
