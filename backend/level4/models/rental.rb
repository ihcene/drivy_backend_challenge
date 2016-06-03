require '../level3/models/rental'

Rental.send(:prepend, Rental::Deductable)
