module Games
  module Deliveries
    class CreateContract < ApplicationContract
      params do
        required(:game_id).filled(:string)
        required(:knocked_pins).filled(:integer, gteq?: 0, lteq?: 10)
      end
    end
  end
end
