class Rental
  # This class introduce discount segments to it's parent class.
  # Ranges are used to find out which discount is applied for each day of the
  # rental.
  # A special range is used for the last segment!
  class DecreasingPriceComputation < Rental::PriceComputation
    DISCOUNT_SEGMENTS = {
      1..1                => 0,
      2..4                => 10,
      5..10               => 30,
      11..Float::INFINITY => 50
    }.freeze

    private

    def time_component_price
      rental.days.map.with_index { |_, i| day_price(i + 1) }.inject(&:+)
    end

    def day_price(index)
      discount(rental.car.price_per_day, discount_percent_for_day(index))
    end

    def discount_percent_for_day(index)
      DISCOUNT_SEGMENTS[
        DISCOUNT_SEGMENTS.keys.find { |key| key.include?(index) }]
    end

    def discount(price, discount_percent)
      (price * (100 - discount_percent) / 100).to_i
    end
  end
end
