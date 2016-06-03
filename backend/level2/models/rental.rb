require '../level1/models/rental'

Rental.send(:prepend, Rental::PriceDecreasable)
