class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.belongs_to :parent, index: true, foreign_key: true
      t.integer :grade
      t.string :teacher

      t.timestamps null: false
    end
  end
end
