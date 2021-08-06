class CheckCurrentFrameCompletion
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def call
    return if game.finished?

    frame = game.current_frame
    frame.finished! if finished_frame?(frame)
    frame.save
  end

  private

  def finished_frame?(frame)
    strike_or_spare = frame.strike? || frame.spare?

    return true if !frame.last_frame? && strike_or_spare
    return true if !strike_or_spare && frame.next_delivery == :third

    frame.next_delivery == :none
  end
end
