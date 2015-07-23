require 'rails_helper'

RSpec.describe "enrollments/show", type: :view do
  before(:each) do
    @enrollment = assign(:enrollment, Enrollment.create!(
      :activity => nil,
      :student => nil,
      :low_income => false,
      :committed => false,
      :paid => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
