require '../level4/models/rental'

Rental.send(:prepend, Rental::Actionnable)
