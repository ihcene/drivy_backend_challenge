class Rental
  # Price computation is not the responsibility of the rental model.
  # So we will handle it here.
  # This one is pretty simple, but can be overriden to do more complicated stuff
  class PriceComputation
    def initialize(rental)
      self.rental = rental
    end

    def self.compute(rental)
      new(rental).price
    end

    def price
      time_component_price + distance_component_price
    end

    private

    attr_accessor :rental

    def time_component_price
      rental.days.count * rental.car.price_per_day
    end

    def distance_component_price
      rental.distance * rental.car.price_per_km
    end
  end
end
