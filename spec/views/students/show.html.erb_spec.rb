require 'rails_helper'

RSpec.describe "students/show", type: :view do
  before(:each) do
    @student = assign(:student, Student.create!(
      :first_name => "First Name",
      :last_name => "Last Name",
      :parent => nil,
      :grade => 1,
      :teacher_name => "Teacher"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Teacher/)
  end
end
