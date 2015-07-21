require 'rails_helper'

RSpec.describe "activities/index", type: :view do
  before(:each) do
    assign(:activities, [
      Activity.create!(
        :name => "Name",
        :instructor => "Instructor",
        :description => "Description",
        :times => "Times",
        :seats => 1,
        :visible => false
      ),
      Activity.create!(
        :name => "Name",
        :instructor => "Instructor",
        :description => "Description",
        :times => "Times",
        :seats => 1,
        :visible => false
      )
    ])
  end

  it "renders a list of activities" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Instructor".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Times".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
