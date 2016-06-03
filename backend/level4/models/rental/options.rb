class Rental
  # This class only computes deductible reduction but can handle other optionnal
  # services
  class Options
    include ActiveModel::Serializers::JSON

    def initialize(rental)
      self.rental = rental
    end

    def deductible_reduction
      rental.deductible_reduction ? rental.days.count * 400 : 0
    end

    private

    attr_accessor :rental

    # Needed for serialization
    def attributes
      {}
    end
  end
end
