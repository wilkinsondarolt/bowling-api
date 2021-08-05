class UpdateGameScore
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def call
    game_score = 0

    game.frames.each do |frame|
      break if unstarted_frame?(frame)

      game_score += frame_score(frame)
      frame.score = game_score
      frame.save
    end

    game.score = game_score
    game.save!
  end

  private

  def unstarted_frame?(frame)
    frame.first_delivery.blank?
  end

  def frame_score(frame)
    score = [frame.first_delivery, frame.second_delivery, frame.third_delivery].compact.reduce(:+) || 0
    score += next_deliveries_score(frame.number, 1) if frame.spare?
    score += next_deliveries_score(frame.number, 2) if frame.strike?

    score
  end

  def deliveries
    @deliveries ||= game.frames.map do |frame|
      [frame.first_delivery, frame.second_delivery].compact
    end
  end

  def next_deliveries_score(frame_number, quantity)
    deliveries[frame_number..9].flatten.slice(0, quantity).reduce(:+) || 0
  end
end
