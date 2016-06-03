class Rental
  # Add commisions to Rental and extending as_json
  module Commissionnable
    def commission
      @commission ||= Commission.new(self)
    end

    def as_json(options = {})
      super(
        {
          include: [
            commission: { methods: %i(insurance_fee assistance_fee drivy_fee) }
          ]
        }.merge(options))
    end
  end
end
