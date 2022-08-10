class CheckoutError < StandardError
  class EmptyItems < CheckoutError
    def status
      422
    end

    def message
      "Can't checkout order without items"
    end
  end
end
