require 'rails_helper'

RSpec.describe "Parents", type: :request do
  describe "GET /parents" do
    it "works! (now write some real specs)" do
      get parents_path
      expect(response).to have_http_status(200)
    end
  end
end
