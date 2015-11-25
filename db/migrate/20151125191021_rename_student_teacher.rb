class RenameStudentTeacher < ActiveRecord::Migration
  def change
    rename_column :students, :teacher, :teacher_name
  end
end
