require 'rails_helper'

RSpec.describe CheckCurrentFrameCompletion, type: :service do
  describe '#call' do
    context 'when the game is started' do
      context 'and is not the last frame' do
        context 'and it was the first delivery' do
          context 'and it was a strike' do
            it 'finishes the frame' do
              frame = create(:frame, number: 1, first_delivery: 10)

              described_class.new(frame.game).call
              frame.reload

              expect(frame).to be_finished
            end

            it 'marks the frame as a strike' do
              frame = create(:frame, number: 1, first_delivery: 10)

              described_class.new(frame.game).call
              frame.reload

              expect(frame.strike?).to eq(true)
            end
          end

          context 'and it was not a strike' do
            it 'does not finish the frame' do
              frame = create(:frame, number: 1, first_delivery: 9)

              described_class.new(frame.game).call
              frame.reload

              expect(frame).not_to be_finished
            end

            it 'does not mark the frame as a strike' do
              frame = create(:frame, number: 1, first_delivery: 9)

              described_class.new(frame.game).call
              frame.reload

              expect(frame.strike?).to eq(false)
            end
          end
        end

        context 'and it was the second delivery' do
          context 'and it was a spare' do
            it 'finishes the frame' do
              frame = create(:frame, number: 1, first_delivery: 9, second_delivery: 1)

              described_class.new(frame.game).call
              frame.reload

              expect(frame).to be_finished
            end

            it 'marks the frame as a spare' do
              frame = create(:frame, number: 1, first_delivery: 9, second_delivery: 1)

              described_class.new(frame.game).call
              frame.reload

              expect(frame.spare?).to eq(true)
            end
          end

          context 'and it was not a spare' do
            it 'finishes the frame' do
              frame = create(:frame, number: 1, first_delivery: 8, second_delivery: 1)

              described_class.new(frame.game).call
              frame.reload

              expect(frame).to be_finished
            end

            it 'does not mark the frame as a spare' do
              frame = create(:frame, number: 1, first_delivery: 8, second_delivery: 1)

              described_class.new(frame.game).call
              frame.reload

              expect(frame.spare?).to eq(false)
            end
          end
        end
      end

      context 'and is the last frame' do
        context 'and it was the first delivery' do
          context 'and it was a strike' do
            it 'does not finish the frame' do
              frame = create(:frame, number: 10, first_delivery: 10)

              described_class.new(frame.game).call
              frame.reload

              expect(frame).not_to be_finished
            end

            it 'marks the frame as a strike' do
              frame = create(:frame, number: 10, first_delivery: 10)

              described_class.new(frame.game).call
              frame.reload

              expect(frame.strike?).to eq(true)
            end
          end

          context 'and it was not a strike' do
            it 'does not finish the frame' do
              frame = create(:frame, number: 10, first_delivery: 9)

              described_class.new(frame.game).call
              frame.reload

              expect(frame).not_to be_finished
            end

            it 'does not mark the frame as a strike' do
              frame = create(:frame, number: 10, first_delivery: 9)

              described_class.new(frame.game).call
              frame.reload

              expect(frame.strike?).to eq(false)
            end
          end
        end

        context 'and it was the second delivery' do
          context 'and it was a strike' do
            it 'does not finish the frame' do
              frame = create(:frame, number: 10, first_delivery: 10, second_delivery: 0)

              described_class.new(frame.game).call
              frame.reload

              expect(frame).not_to be_finished
            end

            it 'marks the frame as a strike' do
              frame = create(:frame, number: 10, first_delivery: 10, second_delivery: 0)

              described_class.new(frame.game).call
              frame.reload

              expect(frame.strike?).to eq(true)
            end

            it 'does not marks the frame as a spare' do
              frame = create(:frame, number: 10, first_delivery: 10, second_delivery: 0)

              described_class.new(frame.game).call
              frame.reload

              expect(frame.spare?).to eq(false)
            end
          end

          context 'and it was a spare' do
            it 'does not finish the frame' do
              frame = create(:frame, number: 10, first_delivery: 9, second_delivery: 1)

              described_class.new(frame.game).call
              frame.reload

              expect(frame).not_to be_finished
            end

            it 'marks the frame as a spare' do
              frame = create(:frame, number: 10, first_delivery: 9, second_delivery: 1)

              described_class.new(frame.game).call
              frame.reload

              expect(frame.spare?).to eq(true)
            end
          end

          context 'and it was a regular delivery' do
            it 'finishes the frame' do
              frame = create(:frame, number: 10, first_delivery: 8, second_delivery: 1)

              described_class.new(frame.game).call
              frame.reload

              expect(frame).to be_finished
            end

            it 'does not mark the frame as a spare' do
              frame = create(:frame, number: 10, first_delivery: 8, second_delivery: 1)

              described_class.new(frame.game).call
              frame.reload

              expect(frame.spare?).to eq(false)
            end
          end
        end

        context 'and it was the third delivery' do
          context 'and it was a strike' do
            it 'finishes the frame' do
              frame = create(:frame, number: 10, first_delivery: 10, second_delivery: 5, third_delivery: 5)

              described_class.new(frame.game).call
              frame.reload

              expect(frame).to be_finished
            end
          end

          context 'and it was a spare' do
            it 'finishes the frame' do
              frame = create(:frame, number: 10, first_delivery: 5, second_delivery: 5, third_delivery: 5)

              described_class.new(frame.game).call
              frame.reload

              expect(frame).to be_finished
            end
          end
        end
      end
    end
  end
end
