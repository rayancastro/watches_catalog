require 'rails_helper'

RSpec.describe "Orders API v1", type: :request do
  describe "/api/v1/orders" do
    describe "GET /checkout" do
      let(:discounted_watch_1) { FactoryBot.create(:watch, unit_price_cents: 300000) }
      let(:discounted_watch_2) { FactoryBot.create(:watch, unit_price_cents: 200000) }
      let(:regular_watch_1) { FactoryBot.create(:watch, unit_price_cents: 100000) }

      before do
        FactoryBot.create(:discount_rule, watch: discounted_watch_1, bundle_size: 3, bundle_price_cents: 800000)
        FactoryBot.create(:discount_rule, watch: discounted_watch_2, bundle_size: 2, bundle_price_cents: 300000)
      end

      it "returns error with no items" do
        post checkout_api_v1_orders_path, params: {}

        json = JSON.parse(response.body)
        expect(json["message"]).to eq "Can't checkout order without items"
      end

      it "returns error with empty items array" do
        post checkout_api_v1_orders_path, params: { "items": [] }

        json = JSON.parse(response.body)
        expect(json["message"]).to eq "Wrong item format"
      end

      it "returns error if an item has an invalid quantity" do
        post checkout_api_v1_orders_path, params: {
          "items": [
            {
              "watch_id": discounted_watch_1.id,
              "quantity": 2
            },
            {
              "watch_id": discounted_watch_2.id,
              "quantity": -5
            },
            {
              "watch_id": regular_watch_1.id,
              "quantity": 10
            }
          ]
        }

        json = JSON.parse(response.body)
        expect(json["message"]).to eq "Invalid item quantity"
      end

      it "returns error if an item has no watch_id" do
        post checkout_api_v1_orders_path, params: {
          "items": [
            {
              "watch_id": "",
              "quantity": 2
            }
          ]
        }

        json = JSON.parse(response.body)
        expect(json["message"]).to eq "Missing watch_id"
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
end
