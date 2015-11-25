require 'rails_helper'

RSpec.describe "students/new", type: :view do
  before(:each) do
    assign(:student, Student.new(
      :first_name => "MyString",
      :last_name => "MyString",
      :parent => nil,
      :grade => 1,
      :teacher_name => "MyString"
    ))
  end

  it "renders new student form" do
    render

    assert_select "form[action=?][method=?]", students_path, "post" do

      assert_select "input#student_first_name[name=?]", "student[first_name]"

      assert_select "input#student_last_name[name=?]", "student[last_name]"

      assert_select "input#student_parent_id[name=?]", "student[parent_id]"

      assert_select "input#student_grade[name=?]", "student[grade]"

      assert_select "input#student_teacher[name=?]", "student[teacher]"
    end
  end
end
