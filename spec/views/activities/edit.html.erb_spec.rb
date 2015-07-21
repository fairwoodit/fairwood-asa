require 'rails_helper'

RSpec.describe "activities/edit", type: :view do
  before(:each) do
    @activity = assign(:activity, Activity.create!(
      :name => "MyString",
      :instructor => "MyString",
      :description => "MyString",
      :times => "MyString",
      :seats => 1,
      :visible => false
    ))
  end

  it "renders the edit activity form" do
    render

    assert_select "form[action=?][method=?]", activity_path(@activity), "post" do

      assert_select "input#activity_name[name=?]", "activity[name]"

      assert_select "input#activity_instructor[name=?]", "activity[instructor]"

      assert_select "input#activity_description[name=?]", "activity[description]"

      assert_select "input#activity_times[name=?]", "activity[times]"

      assert_select "input#activity_seats[name=?]", "activity[seats]"

      assert_select "input#activity_visible[name=?]", "activity[visible]"
    end
  end
end
