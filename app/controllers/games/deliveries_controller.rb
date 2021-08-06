module Games
  class DeliveriesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: -> { head :not_found }
    rescue_from DeliverBall::FinishedGame do
      render(json: ErrorSerializer.render(''), status: :unprocessable_entity)
    end

    def create
      contract_result = Games::Deliveries::CreateContract.new.call(params.permit!.to_h)

      if contract_result.success?
        game = Game.find(contract_result[:game_id])

        DeliverBall.new(game: game, knocked_pins: contract_result[:knocked_pins]).call
        CheckGameCompletion.new(game).call
        UpdateGameScore.new(game).call

        render(json: GamesSerializer.render(game), status: :ok)
      else
        render(json: Contracts::ErrorsSerializer.render(contract_result), status: :unprocessable_entity)
      end
    end
  end
end
