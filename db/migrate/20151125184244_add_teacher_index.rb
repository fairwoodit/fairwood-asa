class AddTeacherIndex < ActiveRecord::Migration
  def change
    add_index :teachers, [:last_name, :first_name], unique: true
  end
end
