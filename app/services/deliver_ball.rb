class DeliverBall
  class FinishedGame < StandardError; end

  attr_reader :game, :knocked_pins

  def initialize(game:, knocked_pins:)
    @game = game
    @knocked_pins = knocked_pins
  end

  def call
    raise FinishedGame if game.finished?

    frame = game.current_frame
    knock_down_pins(frame, knocked_pins)
    frame.save
  end

  private

  def knock_down_pins(frame, knocked_pins)
    case frame.next_delivery
    when :first
      frame.first_delivery = knocked_pins
    when :second
      frame.second_delivery = knocked_pins
    when :third
      frame.third_delivery = knocked_pins
    end
  end
end
