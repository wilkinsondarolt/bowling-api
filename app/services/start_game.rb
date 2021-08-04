class StartGame
  def call
    game = Game.new
    generate_frames(game)
    game.save

    game
  end

  private

  def generate_frames(game)
    (1..10).each do |value|
      game.frames.new(number: value)
    end
  end
end
