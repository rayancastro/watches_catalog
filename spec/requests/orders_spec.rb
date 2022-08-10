require 'rails_helper'

RSpec.describe "Orders", type: :request do
  describe "GET /checkout" do
    it "returns http success" do
      post "/orders/checkout"
      expect(response).to have_http_status(:success)
    end
  end

end
