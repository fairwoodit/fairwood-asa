require 'rails_helper'

RSpec.describe "activities/new", type: :view do
  before(:each) do
    assign(:activity, Activity.new(
      :name => "MyString",
      :instructor => "MyString",
      :description => "MyString",
      :times => "MyString",
      :seats => 1,
      :visible => false
    ))
  end

  it "renders new activity form" do
    render

    assert_select "form[action=?][method=?]", activities_path, "post" do

      assert_select "input#activity_name[name=?]", "activity[name]"

      assert_select "input#activity_instructor[name=?]", "activity[instructor]"

      assert_select "input#activity_description[name=?]", "activity[description]"

      assert_select "input#activity_times[name=?]", "activity[times]"

      assert_select "input#activity_seats[name=?]", "activity[seats]"

      assert_select "input#activity_visible[name=?]", "activity[visible]"
    end
  end
end
