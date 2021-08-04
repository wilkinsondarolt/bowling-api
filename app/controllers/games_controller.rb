class GamesController < ApplicationController
  def create
    game = StartGame.new.call

    render(json: GamesSerializer.render(game), status: :created)
  end
end
