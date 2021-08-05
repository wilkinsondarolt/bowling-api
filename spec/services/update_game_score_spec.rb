require 'rails_helper'

RSpec.describe UpdateGameScore, type: :service do
  describe '#call' do
    context 'when deliveries were made' do
      context 'and a strike were made' do
        context 'and one more delivery was made' do
          it 'adds the next delivery score to the strike frame' do
            game = create(:game, :with_frames)
            game.frames.first.update(kind: :strike, first_delivery: 10)
            game.frames.second.update(first_delivery: 5)

            described_class.new(game).call

            game.reload

            expect(game.frames.first.score).to eq(15)
          end
        end

        context 'and two more deliveries were made' do
          it 'adds the next two deliveries scores to the strike frame' do
            game = create(:game, :with_frames)
            game.frames.first.update(kind: :strike, first_delivery: 10)
            game.frames.second.update(first_delivery: 5, second_delivery: 4)

            described_class.new(game).call
            game.reload

            expect(game.frames.first.score).to eq(19)
          end
        end

        context 'and three more deliveries were made' do
          it 'adds the next two deliveries scores to the strike frame' do
            game = create(:game, :with_frames)
            game.frames.first.update(kind: :strike, first_delivery: 10)
            game.frames.second.update(first_delivery: 5, second_delivery: 4)
            game.frames.third.update(first_delivery: 6)

            described_class.new(game).call
            game.reload

            expect(game.frames.first.score).to eq(19)
          end
        end

        context 'but no more deliveries were made' do
          it 'scores the strike points only' do
            game = create(:game, :with_frames)
            game.frames.first.update(kind: :strike, first_delivery: 10)

            described_class.new(game).call
            game.reload

            expect(game.frames.first.score).to eq(10)
          end
        end
      end

      context 'and a spare were made' do
        context 'and one more delivery was made' do
          it 'adds the next delivery score to the spare frame' do
            game = create(:game, :with_frames)
            game.frames.first.update(kind: :spare, first_delivery: 9, second_delivery: 1)
            game.frames.second.update(first_delivery: 5)

            described_class.new(game).call
            game.reload

            expect(game.frames.first.score).to eq(15)
          end
        end

        context 'and two more deliveries were made' do
          it 'adds the next delivery score to the spare frame' do
            game = create(:game, :with_frames)
            game.frames.first.update(kind: :spare, first_delivery: 9, second_delivery: 1)
            game.frames.second.update(first_delivery: 5, second_delivery: 4)

            described_class.new(game).call
            game.reload

            expect(game.frames.first.score).to eq(15)
          end
        end

        context 'but no more deliveries were made' do
          it 'scores the spare points only' do
            game = create(:game, :with_frames)
            game.frames.first.update(kind: :spare, first_delivery: 9, second_delivery: 1)

            described_class.new(game).call
            game.reload

            expect(game.frames.first.score).to eq(10)
          end
        end
      end

      context 'and a regular delivery was made' do
        context 'and one more delivery was made' do
          it 'does not add the next delivery score to the regular frame' do
            game = create(:game, :with_frames)
            game.frames.first.update(first_delivery: 5, second_delivery: 4)
            game.frames.second.update(first_delivery: 5)

            described_class.new(game).call
            game.reload

            expect(game.frames.first.score).to eq(9)
          end
        end

        context 'and two more deliveries were made' do
          it 'adds the next delivery score to the spare frame' do
            game = create(:game, :with_frames)
            game.frames.first.update(first_delivery: 5, second_delivery: 4)
            game.frames.second.update(first_delivery: 3, second_delivery: 2)

            described_class.new(game).call
            game.reload

            expect(game.frames.first.score).to eq(9)
          end
        end

        context 'but no more deliveries were made' do
          it 'scores the spare points only' do
            game = create(:game, :with_frames)
            game.frames.first.update(first_delivery: 5, second_delivery: 4)

            described_class.new(game).call
            game.reload
            game.reload

            expect(game.frames.first.score).to eq(9)
          end
        end
      end
    end

    context 'when all deliveries were made' do
      it 'sets the game score to 300' do
        game = create(:game)

        (1..9).each do |value|
          create(:frame, game: game, number: value, kind: :strike, first_delivery: 10)
        end
        create(:frame, game: game, number: 10, kind: :strike, first_delivery: 10, second_delivery: 10, third_delivery: 10)

        described_class.new(game).call
        game.reload

        expect(game.score).to eq(300)
      end
    end

    context 'when no deliveries were made' do
      it 'sets the game score to zero' do
        game = create(:game, :with_frames)

        described_class.new(game).call
        game.reload

        expect(game.score).to eq(0)
      end

      it 'sets each frame score to zero' do
        game = create(:game, :with_frames)

        described_class.new(game).call
        game.reload

        frames_score = game.frames.map(&:score)
        expect(frames_score).to all(be == 0)
      end
    end
  end
end
