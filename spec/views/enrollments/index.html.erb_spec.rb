require 'rails_helper'

RSpec.describe "enrollments/index", type: :view do
  before(:each) do
    assign(:enrollments, [
      Enrollment.create!(
        :activity => nil,
        :student => nil,
        :low_income => false,
        :committed => false,
        :paid => false
      ),
      Enrollment.create!(
        :activity => nil,
        :student => nil,
        :low_income => false,
        :committed => false,
        :paid => false
      )
    ])
  end

  it "renders a list of enrollments" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
