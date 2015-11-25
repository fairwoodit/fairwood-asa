class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :room

      t.timestamps null: false
    end
  end
end
