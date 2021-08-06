class CheckGameCompletion
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def call
    return if game.finished?

    frame = game.current_frame
    frame.finished! if frame_finished?(frame)
    frame.save

    game.finished! if game_finished?(game)
    game.save
  end

  private

  def frame_finished?(frame)
    strike_or_spare = frame.strike? || frame.spare?

    return true if !frame.last_frame? && strike_or_spare
    return true if !strike_or_spare && frame.next_delivery == :third

    frame.next_delivery == :none
  end

  def game_finished?(game)
    open_frames = game.frames.filter(&:started?)

    open_frames.empty?
  end
end
