require '../level5/models/rental'

class Rental
  # We consider a modification as a fully-featured rental via inheritance.
  class Modification < Rental
    attr_accessor :rental_id

    # This way, modification can compute it own independant actions (via super)
    # and compute variation between these values and rental values in a painless
    # way
    def actions
      super.map do |action|
        rental_action = rental.actions.find { |e| e.who == action.who }

        Action.new(
          who: action.who,
          relative_amount:
            action.relative_amount - rental_action.relative_amount)
      end
    end

    def rental
      Rental.find(rental_id)
    end

    # Delegate all rental-like attributes to rental when nil.
    # 'Cause modification data includes only modified attributes

    def car_id
      super || rental.car_id
    end

    def start_date
      super || rental.start_date
    end

    def end_date
      super || rental.end_date
    end

    def distance
      super || rental.distance
    end

    # Trickier to deal with booleans, false lead to faylty delegation
    def deductible_reduction
      super.nil? ? rental.deductible_reduction : super
    end

    def as_json(*)
      serializable_hash(
        only: [:id, :rental_id],
        include: [{ actions: { only: :who, methods: [:type, :amount] } }])
    end
  end
end
