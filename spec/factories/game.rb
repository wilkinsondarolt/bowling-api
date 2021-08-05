FactoryBot.define do
  factory :game do
    trait :with_frames do
      after(:create) do |game|
        (1..10).each do |value|
          create(:frame, game: game, number: value)
        end
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
