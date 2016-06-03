class Rental
  # Add actions to Rental and overrid json
  module Actionnable
    def actions
      @actions ||= Action.all(self)
    end

    # The output is too different from earlier levels, thus, we wont rely on
    # super but directly call serializable_hash
    def as_json(*)
      serializable_hash(
        only: [:id],
        include: [{ actions: { only: :who, methods: [:type, :amount] } }])
    end
  end
end
