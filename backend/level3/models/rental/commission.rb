class Rental
  # Simple computation of the different fees. Nothing special.
  class Commission
    include ActiveModel::Serializers::JSON

    def initialize(rental)
      self.rental = rental
    end

    def insurance_fee
      (commission / 2).to_i
    end

    def assistance_fee
      (100 * rental.days.count)
    end

    def drivy_fee
      commission - insurance_fee - assistance_fee
    end

    def all
      insurance_fee + assistance_fee + drivy_fee
    end

    private

    attr_accessor :rental

    def commission
      (rental.price * 0.3).to_i
    end

    # needed for serialization
    def attributes
      {}
    end
  end
end
