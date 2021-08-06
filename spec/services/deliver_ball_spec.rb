require 'rails_helper'

RSpec.describe DeliverBall, type: :service do
  describe '#call' do
    context 'when the game is started' do
      context 'and is the first delivery of the frame' do
        it 'updates the first delivery of the frame' do
          frame = create(:frame, number: 1)

          described_class.new(game: frame.game, knocked_pins: 5).call
          frame.reload

          expect(frame.first_delivery).to eq(5)
        end

        context 'and it was a strike' do
          it 'marks the frame as a strike' do
            frame = create(:frame, number: 1)

            described_class.new(game: frame.game, knocked_pins: 10).call
            frame.reload

            expect(frame.strike?).to eq(true)
          end
        end

        context 'and it was not a strike' do
          it 'does not mark the frame as a strike' do
            frame = create(:frame, number: 1)

            described_class.new(game: frame.game, knocked_pins: 5).call
            frame.reload

            expect(frame.strike?).to eq(false)
          end
        end
      end

      context 'and is the second delivery of the frame' do
        it 'updates the second delivery of the frame' do
          frame = create(:frame, number: 1, first_delivery: 5)

          described_class.new(game: frame.game, knocked_pins: 4).call
          frame.reload

          expect(frame.second_delivery).to eq(4)
        end

        context 'and it was a spare' do
          it 'marks the frame as a spare' do
            frame = create(:frame, number: 1, first_delivery: 9)

            described_class.new(game: frame.game, knocked_pins: 1).call
            frame.reload

            expect(frame.spare?).to eq(true)
          end
        end

        context 'and it was not a spare' do
          it 'does not mark the frame as a spare' do
            frame = create(:frame, number: 1, first_delivery: 8)

            described_class.new(game: frame.game, knocked_pins: 1).call
            frame.reload

            expect(frame.spare?).to eq(false)
          end
        end
      end

      context 'and is the third delivery of the frame' do
        it 'updates the third delivery of the frame' do
          frame = create(:frame, number: 1, first_delivery: 5, second_delivery: 5)

          described_class.new(game: frame.game, knocked_pins: 6).call
          frame.reload

          expect(frame.third_delivery).to eq(6)
        end
      end
    end

    context 'when the game is finished' do
      it 'raises an finished game error' do
        game = create(:game, :finished)

        expect do
          described_class.new(game: game, knocked_pins: 10).call
        end.to raise_error(DeliverBall::FinishedGame)
      end
    end
  end
end
