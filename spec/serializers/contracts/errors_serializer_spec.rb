require 'rails_helper'

RSpec.describe Contracts::ErrorsSerializer do
  describe '#as_json' do
    context 'when the contract is valid' do
      it 'returns an empty array' do
        params = { game_id: 'id', knocked_pins: 5 }
        contract = Games::Deliveries::CreateContract.new.call(params)

        result_json = described_class.new(contract).as_json

        expect(result_json).to eq({ errors: [] })
      end
    end

    context 'when the contract is invalid' do
      it 'returns an array containing the contract errors' do
        params = { game_id: 'id', knocked_pins: -1 }
        contract = Games::Deliveries::CreateContract.new.call(params)

        result_json = described_class.new(contract).as_json

        expect(result_json).to eq(
          {
            errors: [{
              field: 'knocked_pins',
              detail: 'is lesser than 0'
            }]
          }
        )
      end
    end
  end
end
