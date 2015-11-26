class AddTeacherToStudents < ActiveRecord::Migration
  def change
    add_reference :students, :teacher, index: true, foreign_key: true
  end
end
