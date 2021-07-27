require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /restricted" do
    it "returns http success" do
      get "/home/restricted"
      expect(response).to have_http_status(:success)
    end
  end

end
