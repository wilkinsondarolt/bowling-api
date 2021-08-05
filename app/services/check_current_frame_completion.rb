class CheckCurrentFrameCompletion
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def call
    return if game.finished?

    frame = game.current_frame
    frame.strike! if strike?(frame)
    frame.spare! if spare?(frame)
    frame.finished! if finished_frame?(frame)
    frame.save
  end

  private

  def strike?(frame)
    frame.first_delivery == 10
  end

  def spare?(frame)
    return false if frame.strike?

    total_knocked_pins = [frame.first_delivery, frame.second_delivery].compact.reduce(:+)
    total_knocked_pins == 10
  end

  def finished_frame?(frame)
    strike_or_spare = frame.strike? || frame.spare?

    return true if !frame.last_frame? && strike_or_spare
    return true if !strike_or_spare && frame.next_delivery == :third

    frame.next_delivery == :none
  end
end
