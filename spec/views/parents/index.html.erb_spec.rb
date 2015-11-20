require 'rails_helper'

RSpec.describe "parents/index", type: :view do
  before(:each) do
    assign(:parents, [
      Parent.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :phone_number => "Phone Number",
        :role => "Role"
      ),
      Parent.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :phone_number => "Phone Number",
        :role => "Role"
      )
    ])
  end

  it "renders a list of parents" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
    assert_select "tr>td", :text => "School".to_s, :count => 2
    assert_select "tr>td", :text => "Role".to_s, :count => 2
  end
end
