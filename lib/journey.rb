class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :journey

  def initialize(station = nil)
    @journey = {}
    @journey[:entry] = station
  end

  def start_journey(station)
    @journey[:entry] = station
  end

  def end_journey(station)
    @journey[:exit] = station
  end

  def in_journey?
    !!journey[:entry]
  end

  def journey_complete?
    !!journey[:entry] && !!journey[:exit]
  end

  def fare
    return calculate_fare if journey_complete?
    PENALTY_FARE
  end

  private

  def calculate_fare
    MINIMUM_FARE + (journey[:entry].zone - journey[:exit].zone).abs
  end
end
