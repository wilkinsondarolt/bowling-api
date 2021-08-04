FactoryBot.define do
  factory :game do
    after(:create) do |game|
      (1..10).each do |value|
        create(:frame, game: game, number: value)
      end
    end
  end
end
