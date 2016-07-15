require_relative 'station'
require_relative 'journey'
require_relative 'journey_log'

class Oystercard

  LIMIT = 90

  attr_reader :balance

  def initialize
    @balance = 0
    @log = JourneyLog.new(Journey)
  end

  def top_up(amount)
    fail "card limit #{LIMIT} exceeded" if @balance + amount > LIMIT
    @balance += amount
  end

  def touch_in(station)
    message = "Insufficient balance. Minimum £#{Journey::MINIMUM_FARE} is required"
    fail message if @balance < Journey::MINIMUM_FARE
    # deduct(@log.journey.fare) if 
    @log.start(station)
  end

  def touch_out(station)
    @log.finish(station)
    deduct(@log.journey.fare)
  end

  def journey_history
    @log.journeys
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
