require 'rails_helper'

RSpec.describe 'Games', type: :request do
  describe 'Show a game' do
    context 'when the game exist' do
      it 'returns an ok status' do
        game = create(:game)

        get game_path(game)

        expect(response).to have_http_status(:ok)
      end

      it 'returns the created game information' do
        game = create(:game)

        get game_path(game)

        expect(response.parsed_body).to include(
          'score' => 0,
          'status' => 'started',
          'frames' => include(
            a_hash_including(
              'number' => 1,
              'score' => 0,
              'status' => 'started',
              'kind' => 'regular',
              'first_delivery' => nil,
              'second_delivery' => nil,
              'third_delivery' => nil
            ),
            a_hash_including(
              'number' => 2,
              'score' => 0,
              'status' => 'started',
              'kind' => 'regular',
              'first_delivery' => nil,
              'second_delivery' => nil,
              'third_delivery' => nil
            ),
            a_hash_including(
              'number' => 3,
              'score' => 0,
              'status' => 'started',
              'kind' => 'regular',
              'first_delivery' => nil,
              'second_delivery' => nil,
              'third_delivery' => nil
            ),
            a_hash_including(
              'number' => 4,
              'score' => 0,
              'status' => 'started',
              'kind' => 'regular',
              'first_delivery' => nil,
              'second_delivery' => nil,
              'third_delivery' => nil
            ),
            a_hash_including(
              'number' => 5,
              'score' => 0,
              'status' => 'started',
              'kind' => 'regular',
              'first_delivery' => nil,
              'second_delivery' => nil,
              'third_delivery' => nil
            ),
            a_hash_including(
              'number' => 6,
              'score' => 0,
              'status' => 'started',
              'kind' => 'regular',
              'first_delivery' => nil,
              'second_delivery' => nil,
              'third_delivery' => nil
            ),
            a_hash_including(
              'number' => 7,
              'score' => 0,
              'status' => 'started',
              'kind' => 'regular',
              'first_delivery' => nil,
              'second_delivery' => nil,
              'third_delivery' => nil
            ),
            a_hash_including(
              'number' => 8,
              'score' => 0,
              'status' => 'started',
              'kind' => 'regular',
              'first_delivery' => nil,
              'second_delivery' => nil,
              'third_delivery' => nil
            ),
            a_hash_including(
              'number' => 9,
              'score' => 0,
              'status' => 'started',
              'kind' => 'regular',
              'first_delivery' => nil,
              'second_delivery' => nil,
              'third_delivery' => nil
            ),
            a_hash_including(
              'number' => 10,
              'score' => 0,
              'status' => 'started',
              'kind' => 'regular',
              'first_delivery' => nil,
              'second_delivery' => nil,
              'third_delivery' => nil
            )
          )
        )
      end
    end

    context 'when the game does not exist' do
      it 'returns a not found status' do
        get game_path('unknown_game_id')

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
