class RemoveTeacherNameFromStudents < ActiveRecord::Migration
  def change
    remove_column :students, :teacher_name
  end
end
