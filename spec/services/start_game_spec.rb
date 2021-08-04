require 'rails_helper'

RSpec.describe StartGame, type: :service do
  describe '#call' do
    it 'creates a new game' do
      game = described_class.new.call

      expect(game).to be_persisted
    end

    it 'creates a open game' do
      game = described_class.new.call

      expect(game).to be_started
    end

    it 'creates a game with ten frames' do
      game = described_class.new.call
      frame_count = game.frames.count

      expect(frame_count).to eq(10)
    end
  end
end
