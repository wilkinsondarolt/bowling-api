require 'rails_helper'

RSpec.describe 'Games', type: :request do
  describe 'Create a new game' do
    it 'returns a created status' do
      post games_path

      expect(response).to have_http_status(:created)
    end

    it 'returns the created game information' do
      post games_path

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
end
