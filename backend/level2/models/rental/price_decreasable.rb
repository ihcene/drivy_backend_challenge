class Rental
  # Preprend this module into Rental to overrid price. This is a Ruby 2 way
  # to avoid alias_method_chain
  module PriceDecreasable
    def price
      @price ||= DecreasingPriceComputation.compute(self)
    end
  end
end
