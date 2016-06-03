class Rental
  # This model is used to represent rental actions.
  # It deduce operation type (credit or debit) and the absolute amount value
  class Action < BaseModel
    attr_accessor :who, :relative_amount

    def type
      relative_amount > 0 ? 'credit' : 'debit'
    end

    def amount
      relative_amount.abs
    end

    def as_json(*)
      super(only: :who, methods: [:type, :amount])
    end

    class << self
      def all(rental)
        [].tap do |all|
          all << driver_action(rental)
          all << owner_action(rental)
          all << insurance_action(rental)
          all << assistance_action(rental)
          all << drivy_action(rental)
        end
      end

      def driver_action(rental)
        new(who: 'driver',
            relative_amount:
              -(rental.price + rental.options.deductible_reduction))
      end

      def owner_action(rental)
        new(who: 'owner',
            relative_amount: rental.price - rental.commission.all)
      end

      def insurance_action(rental)
        new(who: 'insurance',
            relative_amount: rental.commission.insurance_fee)
      end

      def assistance_action(rental)
        new(who: 'assistance',
            relative_amount: rental.commission.assistance_fee)
      end

      def drivy_action(rental)
        new(who: 'drivy',
            relative_amount:
              rental.commission.drivy_fee +
              rental.options.deductible_reduction)
      end
    end
  end
end
