class OrdersController < ApplicationController
  def checkout
    # Receive request with list of watches to order

    # Raise error if no items are present
    raise CheckoutError::EmptyItems unless params[:items].present?
    items = params[:items]

    # Calculate the order cost
    order_items = items.map do |item|
      # Raise error if item is invalid
      raise CheckoutError::InvalidItemQuantity unless item[:quantity].present? && item[:quantity].positive?

      watch = Watch.find(item.dig(:watch_id))
      quantity = item[:quantity]
      unit_price = watch.unit_price_cents / 100.0
      total_price = unit_price * quantity

      {
        watch_id: watch.id,
        quantity: item[:quantity],
        unit_price: unit_price,
        total_price: total_price
      }
    end
    order_total_price = order_items.sum { |i| i.dig(:total_price)}

    # Respond a formatted JSON with the order details
    render json: {
      order_items: order_items,
      curency: "USD",
      order_total_price: order_total_price
    }

  # Handle specific errors and respond a formatted JSON
  rescue CheckoutError => e
    render json: { error: e, status: e.status, message: e.message}
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.class, status: 404, message: e.message }
  end
end
