require 'rails_helper'

RSpec.describe "enrollments/new", type: :view do
  before(:each) do
    assign(:enrollment, Enrollment.new(
      :activity => nil,
      :student => nil,
      :low_income => false,
      :committed => false,
      :paid => false
    ))
  end

  it "renders new enrollment form" do
    render

    assert_select "form[action=?][method=?]", enrollments_path, "post" do

      assert_select "input#enrollment_activity_id[name=?]", "enrollment[activity_id]"

      assert_select "input#enrollment_student_id[name=?]", "enrollment[student_id]"

      assert_select "input#enrollment_low_income[name=?]", "enrollment[low_income]"

      assert_select "input#enrollment_committed[name=?]", "enrollment[committed]"

      assert_select "input#enrollment_paid[name=?]", "enrollment[paid]"
    end
  end
end
