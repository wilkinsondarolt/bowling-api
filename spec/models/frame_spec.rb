require 'rails_helper'

RSpec.describe Frame, type: :model do
  describe '#next_delivery' do
    context 'when the frame is started' do
      context 'when no deliveries were made' do
        it 'returns the first delivery' do
          frame = create(:frame, number: 1)

          expect(frame.next_delivery).to eq(:first)
        end
      end

      context 'when the first delivery was made' do
        it 'returns the second delivery' do
          frame = create(:frame, number: 1, first_delivery: 5)

          expect(frame.next_delivery).to eq(:second)
        end
      end

      context 'when the first and second delivery were made' do
        it 'returns the second delivery' do
          frame = create(:frame, number: 1, first_delivery: 5, second_delivery: 4)

          expect(frame.next_delivery).to eq(:third)
        end
      end
    end

    context 'when the frame is finished' do
      it 'returns none' do
        frame = create(:frame, :finished, number: 1)

        expect(frame.next_delivery).to eq(:none)
      end
    end
  end
end
