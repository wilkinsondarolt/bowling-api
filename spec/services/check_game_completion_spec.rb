require 'rails_helper'

RSpec.describe CheckGameCompletion, type: :service do
  describe '#call' do
    context 'when the game is started' do
      context 'and is not the last frame' do
        context 'and it was the first delivery' do
          context 'and it was a strike' do
            it 'finishes the frame' do
              game = create(:game, :with_frames)
              frame = game.frames.first
              frame.update(kind: :strike, first_delivery: 10)

              described_class.new(game).call
              frame.reload

              expect(frame).to be_finished
            end
          end

          context 'and it was not a strike' do
            it 'does not finish the frame' do
              game = create(:game, :with_frames)
              frame = game.frames.first
              frame.update(first_delivery: 9)

              described_class.new(game).call
              frame.reload

              expect(frame).not_to be_finished
            end
          end
        end

        context 'and it was the second delivery' do
          context 'and it was a spare' do
            it 'finishes the frame' do
              game = create(:game, :with_frames)
              frame = game.frames.first
              frame.update(kind: :spare, first_delivery: 9, second_delivery: 1)

              described_class.new(game).call
              frame.reload

              expect(frame).to be_finished
            end
          end

          context 'and it was not a spare' do
            it 'finishes the frame' do
              game = create(:game, :with_frames)
              frame = game.frames.first
              frame.update(first_delivery: 8, second_delivery: 1)

              described_class.new(game).call
              frame.reload

              expect(frame).to be_finished
            end
          end
        end
      end

      context 'and is the last frame' do
        context 'and it was the first delivery' do
          context 'and it was a strike' do
            it 'does not finish the frame' do
              game = create(:game, :last_frame_pending)
              frame = game.frames.last
              frame.update(kind: :strike, first_delivery: 10)

              described_class.new(game).call
              frame.reload

              expect(frame).not_to be_finished
            end
          end

          context 'and it was not a strike' do
            it 'does not finish the frame' do
              game = create(:game, :last_frame_pending)
              frame = game.frames.last
              frame.update(first_delivery: 9)

              described_class.new(game).call
              frame.reload

              expect(frame).not_to be_finished
            end
          end
        end

        context 'and it was the second delivery' do
          context 'and it was a strike' do
            it 'does not finish the frame' do
              game = create(:game, :last_frame_pending)
              frame = game.frames.last
              frame.update(kind: :strike, first_delivery: 10, second_delivery: 0)

              described_class.new(game).call
              frame.reload

              expect(frame).not_to be_finished
            end
          end

          context 'and it was a spare' do
            it 'does not finish the frame' do
              game = create(:game, :last_frame_pending)
              frame = game.frames.last
              frame.update(kind: :spare, first_delivery: 9, second_delivery: 1)

              described_class.new(game).call
              frame.reload

              expect(frame).not_to be_finished
            end
          end

          context 'and it was a regular delivery' do
            it 'finishes the frame' do
              game = create(:game, :last_frame_pending)

              frame = game.frames.last
              frame.update(first_delivery: 8, second_delivery: 1)

              described_class.new(game).call
              frame.reload

              expect(frame).to be_finished
            end

            it 'finishes the game' do
              game = create(:game, :last_frame_pending)

              frame = game.frames.last
              frame.update(first_delivery: 8, second_delivery: 1)

              described_class.new(game).call
              game.reload

              expect(game).to be_finished
            end
          end
        end

        context 'and it was the third delivery' do
          context 'and it was a strike' do
            it 'finishes the frame' do
              game = create(:game, :last_frame_pending)
              frame = game.frames.last
              frame.update(kind: :strike, first_delivery: 10, second_delivery: 5, third_delivery: 5)

              described_class.new(game).call
              frame.reload

              expect(frame).to be_finished
            end

            it 'finishes the game' do
              game = create(:game, :last_frame_pending)
              frame = game.frames.last
              frame.update(kind: :strike, first_delivery: 10, second_delivery: 5, third_delivery: 5)

              described_class.new(game).call
              game.reload

              expect(game).to be_finished
            end
          end

          context 'and it was a spare' do
            it 'finishes the frame' do
              game = create(:game, :last_frame_pending)
              frame = game.frames.last
              frame.update(kind: :spare, first_delivery: 5, second_delivery: 5, third_delivery: 5)

              described_class.new(game).call
              frame.reload

              expect(frame).to be_finished
            end

            it 'finishes the game' do
              game = create(:game, :last_frame_pending)
              frame = game.frames.last
              frame.update(kind: :spare, first_delivery: 5, second_delivery: 5, third_delivery: 5)

              described_class.new(game).call
              frame.reload

              expect(frame).to be_finished
            end
          end
        end
      end
    end
  end
end
