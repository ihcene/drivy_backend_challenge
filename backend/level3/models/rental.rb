require '../level2/models/rental'

Rental.send(:prepend, Rental::Commissionnable)
