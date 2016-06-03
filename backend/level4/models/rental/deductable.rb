class Rental
  # Comment to make Rubocop happy (:
  module Deductable
    attr_accessor :deductible_reduction

    def options
      @options ||= Options.new(self)
    end

    def as_json(options = {})
      super(
        {
          include: [
            { options: { methods: %i(deductible_reduction) } },
            { commission:
              { methods: %i(insurance_fee assistance_fee drivy_fee) } }]
        }.merge(options))
    end
  end
end
