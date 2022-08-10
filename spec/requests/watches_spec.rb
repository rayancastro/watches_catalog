require 'rails_helper'

RSpec.describe "Watches", type: :request do
  describe "GET /watches" do
    it "returns http success" do
      get "/watches"
      expect(response).to have_http_status(:success)
    end
  end
end
