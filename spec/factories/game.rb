FactoryBot.define do
  factory :game do
    trait :with_frames do
      after(:create) do |game|
        (1..10).each do |value|
          create(:frame, game: game, number: value)
        end
      end
    end

    trait :last_frame_pending do
      after(:create) do |game|
        game.score = 81

        (1..9).each do |value|
          create(
            :frame,
            :finished,
            game: game,
            score: 9 * value,
            first_delivery: 5,
            second_delivery: 4,
            number: value
          )
        end

        create(:frame, game: game, number: 10)
      end
    end

    trait :finished do
      after(:create) do |game|
        game.score = 90
        game.finished!

        (1..10).each do |value|
          create(
            :frame,
            :finished,
            game: game,
            score: 9 * value,
            first_delivery: 5,
            second_delivery: 4,
            number: value
          )
        end
      end
    end
  end
end
