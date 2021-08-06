require 'rails_helper'

RSpec.describe 'Games', type: :request do
  describe 'Create a delivery' do
    context 'when the game exist' do
      context 'and the game is started' do
        context 'and the params are valid' do
          it 'returns a ok status' do
            game = create(:game, :with_frames)
            params = { knocked_pins: 10 }

            post game_deliveries_path(game), params: params

            expect(response).to have_http_status(:ok)
          end

          it 'returns the updated game information' do
            game = create(:game, :with_frames)
            params = { knocked_pins: 10 }

            post game_deliveries_path(game), params: params

            expect(response.parsed_body).to include(
              'score' => 10,
              'status' => 'started',
              'frames' => include(
                a_hash_including(
                  'number' => 1,
                  'score' => 10,
                  'status' => 'finished',
                  'kind' => 'strike',
                  'first_delivery' => 10,
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

        context 'but the params are invalid' do
          it 'returns an unprocessable entity status' do
            game = create(:game)
            params = { knocked_pins: -12 }

            post game_deliveries_path(game), params: params

            expect(response).to have_http_status(:unprocessable_entity)
          end

          it 'returns the error message' do
            game = create(:game)
            params = { knocked_pins: -12 }

            post game_deliveries_path(game), params: params

            expect(response.parsed_body).to match(
              {
                'errors' => [
                  {
                    'detail' => 'is lesser than 0',
                    'field' => 'knocked_pins'
                  }
                ]
              }
            )
          end
        end
      end

      context 'but the game is finished' do
        it 'returns an unprocessable entity status' do
          game = create(:game, :finished)
          params = { knocked_pins: 5 }

          post game_deliveries_path(game), params: params

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns the error message' do
          game = create(:game, :finished)
          params = { knocked_pins: 5 }

          post game_deliveries_path(game), params: params

          expect(response.parsed_body).to match(
            {
              'errors' => ['Game finished.']
            }
          )
        end
      end
    end

    context 'when the game does not exist' do
      it 'returns a not found status' do
        params = { knocked_pins: 5 }

        post game_deliveries_path('unknown_game_id'), params: params

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
