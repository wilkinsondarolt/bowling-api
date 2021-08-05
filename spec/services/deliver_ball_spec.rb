require 'rails_helper'

RSpec.describe DeliverBall, type: :service do
  describe '#call' do
    context 'when the game is started' do
      context 'and is the first delivery of the frame' do
        it 'updates the first delivery of the frame' do
          game = create(:game)
          frame = create(:frame, game: game, number: 1)

          described_class.new(game: game, knocked_pins: 5).call
          frame.reload

          expect(frame.first_delivery).to eq(5)
        end
      end

      context 'and is the second delivery of the frame' do
        it 'updates the second delivery of the frame' do
          game = create(:game)
          frame = create(:frame, game: game, number: 1, first_delivery: 5)

          described_class.new(game: game, knocked_pins: 4).call
          frame.reload

          expect(frame.second_delivery).to eq(4)
        end
      end

      context 'and is the third delivery of the frame' do
        it 'updates the third delivery of the frame' do
          game = create(:game)
          frame = create(:frame, game: game, number: 1, first_delivery: 5, second_delivery: 5)

          described_class.new(game: game, knocked_pins: 6).call
          frame.reload

          expect(frame.third_delivery).to eq(6)
        end
      end
    end

    context 'when the game is finished' do
      it 'raises an finished game error' do
        game = create(:game, :finished)

        expect {
          described_class.new(game: game, knocked_pins: 10).call
        }.to raise_error(DeliverBall::FinishedGame)
      end
    end
  end
end
