class CheckoutError < StandardError

  def status
    422
  end

  def message
    "Error on Checkout"
  end

  class EmptyItems < CheckoutError
    def message
      "Can't checkout order without items"
    end
  end

  class WrongItemFormat < CheckoutError
    def message
      "Wrong item format"
    end
  end

  class MissingWatchId < CheckoutError
    def message
      "Missing watch_id"
    end
  end

  class InvalidItemQuantity < CheckoutError
    def message
      "Invalid item quantity"
    end
  end
end
