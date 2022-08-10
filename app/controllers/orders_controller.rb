class OrdersController < ApplicationController
  def checkout
    # Receive request with list of watches to order

    # Raise error if no items are present
    raise CheckoutError::EmptyItems unless params[:items].present?

    # Group all items with the same watch_id into one
    items = params[:items].group_by {|item| item[:watch_id] }.map do |watch_id, grouped_items|
      {
        watch_id: watch_id,
        quantity: grouped_items.sum {|item| item[:quantity].to_i }
      }
    end

    # Calculate the order cost
    order_items = items.map do |item|
      # Raise error if item is invalid
      raise CheckoutError::InvalidItemQuantity unless item[:quantity].present? && item[:quantity].positive?

      watch = Watch.find(item.dig(:watch_id))
      quantity = item[:quantity]
      unit_price = watch.unit_price_cents / 100.0
      total_price = unit_price * quantity

      # Apply discounts
      if watch.discounted?
        discount_bundles =  quantity / watch.discount_rule.discount_quantity
        bundles_price = discount_bundles * watch.discount_rule.discounted_price_cents / 100.0

        remaining_units = quantity % watch.discount_rule.discount_quantity
        final_price = bundles_price + remaining_units * unit_price
      end

      final_price ||= total_price
      applied_discount = total_price - final_price

      {
        watch_id: watch.id,
        watch_name: watch.name,
        quantity: item[:quantity],
        unit_price: unit_price,
        total_price: total_price,
        applied_discount: applied_discount,
			  final_price: final_price
      }
    end

    # Respond a formatted JSON with the order details
    order_total_price = order_items.sum { |i| i.dig(:total_price)}
    order_applied_discount = order_items.sum { |i| i.dig(:applied_discount)}
    order_final_price = order_items.sum { |i| i.dig(:final_price)}

    render json: {
      order_identifier: SecureRandom.hex(4),
      order_items: order_items,
      curency: "USD",
      order_total_price: order_total_price,
      order_total_discount: order_applied_discount,
      order_final_price: order_final_price
    }

  # Handle specific errors and respond a formatted JSON
  rescue CheckoutError => e
    render json: { error: e, status: e.status, message: e.message}
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.class, status: 404, message: e.message }
  end
end
