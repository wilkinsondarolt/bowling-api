class GamesController < ApplicationController
  def create
    game = StartGame.new.call

    render(json: GamesSerializer.render(game), status: :created)
  end

  def show
    game = Game.find(params[:id])

    render(json: GamesSerializer.render(game), status: :ok)
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end
end
