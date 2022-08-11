require 'rails_helper'

RSpec.describe "Orders", type: :request do
  describe "GET /checkout" do
    let(:discounted_watch_1) { FactoryBot.create(:watch, unit_price_cents: 300000) }
    let(:discounted_watch_2) { FactoryBot.create(:watch, unit_price_cents: 200000) }
    let(:regular_watch_1) { FactoryBot.create(:watch, unit_price_cents: 100000) }

    before do
      FactoryBot.create(:discount_rule, watch: discounted_watch_1, discount_quantity: 3, discounted_price_cents: 800000)
      FactoryBot.create(:discount_rule, watch: discounted_watch_2, discount_quantity: 2, discounted_price_cents: 300000)
    end

    it "calculates the proper order amount, with discounts" do
      post checkout_api_v1_orders_path, params: {
        "items": [
          {
            "watch_id": discounted_watch_1.id,
            "quantity": 2
          },
          {
            "watch_id": discounted_watch_2.id,
            "quantity": 5
          },
          {
            "watch_id": regular_watch_1.id,
            "quantity": 10
          }
        ]
      }
      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)
      expect(json["order_total_price"]).to eq 26000
      expect(json["order_final_price"]).to eq 24000
    end

    it "properly groups multiple items with the same watch_id" do
      post checkout_api_v1_orders_path, params: {
        "items": [
          {
            "watch_id": discounted_watch_1.id,
            "quantity": 2
          },
          {
            "watch_id": discounted_watch_2.id,
            "quantity": 1
          },
          {
            "watch_id": regular_watch_1.id,
            "quantity": 4
          },
          {
            "watch_id": discounted_watch_2.id,
            "quantity": 1
          },
          {
            "watch_id": regular_watch_1.id,
            "quantity": 6
          },
          {
            "watch_id": discounted_watch_2.id,
            "quantity": 1
          },
        ]
      }
      expect(response).to have_http_status(:success)

      json = JSON.parse(response.body)
      expect(json["order_total_price"]).to eq 22000
      expect(json["order_final_price"]).to eq 21000
    end
  end
end
