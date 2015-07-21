require 'rails_helper'

RSpec.describe "activities/show", type: :view do
  before(:each) do
    @activity = assign(:activity, Activity.create!(
      :name => "Name",
      :instructor => "Instructor",
      :description => "Description",
      :times => "Times",
      :seats => 1,
      :visible => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Instructor/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Times/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/false/)
  end
end
