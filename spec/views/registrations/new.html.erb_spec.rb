require 'rails_helper'

RSpec.describe "registrations/new", type: :view do
  before(:each) do
    assign(:registration, Registration.new(
      :activity => nil,
      :student => nil,
      :low_income => false,
      :committed => false,
      :paid => false
    ))
  end

  it "renders new registration form" do
    render

    assert_select "form[action=?][method=?]", registrations_path, "post" do

      assert_select "input#registration_activity_id[name=?]", "registration[activity_id]"

      assert_select "input#registration_student_id[name=?]", "registration[student_id]"

      assert_select "input#registration_low_income[name=?]", "registration[low_income]"

      assert_select "input#registration_committed[name=?]", "registration[committed]"

      assert_select "input#registration_paid[name=?]", "registration[paid]"
    end
  end
end
