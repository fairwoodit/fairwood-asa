require 'rails_helper'

RSpec.describe "students/index", type: :view do
  before(:each) do
    assign(:students, [
      Student.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :parent => nil,
        :grade => 1,
        :teacher => "Teacher"
      ),
      Student.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :parent => nil,
        :grade => 1,
        :teacher => "Teacher"
      )
    ])
  end

  it "renders a list of students" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Teacher".to_s, :count => 2
  end
end
