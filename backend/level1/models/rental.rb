# This is the main class of the application.
# It has it's own price computation class and can be inherited or extended
class Rental < BaseModel
  attr_accessor :id, :car_id, :start_date, :end_date, :distance

  def car
    @car ||= Car.find(car_id)
  end

  def days
    (Date.parse(start_date)..Date.parse(end_date)).to_a
  end

  def price
    @price ||= PriceComputation.compute(self)
  end

  def as_json(options = {})
    super({ methods: %i(id price), only: [] }.merge(options))
  end
end
