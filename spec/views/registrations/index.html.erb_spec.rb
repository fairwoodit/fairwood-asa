require 'rails_helper'

RSpec.describe "registrations/index", type: :view do
  before(:each) do
    assign(:registrations, [
      Registration.create!(
        :activity => nil,
        :student => nil,
        :low_income => false,
        :committed => false,
        :paid => false
      ),
      Registration.create!(
        :activity => nil,
        :student => nil,
        :low_income => false,
        :committed => false,
        :paid => false
      )
    ])
  end

  it "renders a list of registrations" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
