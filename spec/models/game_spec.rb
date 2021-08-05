require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '#current_frame' do
    context 'when all the frames are started' do
      it 'returns the first frame' do
        game = create(:game, :with_frames)

        frame = game.current_frame

        expect(frame.number).to eq(1)
      end
    end

    context 'when there are finished frames' do
      it 'returns the first started frame' do
        game = create(:game)
        create(:frame, :finished, game: game, number: 1, score: 9, first_delivery: 5, second_delivery: 4)
        (2..10).each { |value| create(:frame, game: game, number: value) }

        frame = game.current_frame

        expect(frame.number).to eq(2)
      end
    end

    context 'when all frames are finished' do
      it 'returns nil' do
        game = create(:game, :finished)

        frame = game.current_frame

        expect(frame).to eq(nil)
      end
    end
  end
end
