FactoryBot.define do
  factory :frame do
    game

    trait :finished do
      status { :finished }
    end
  end
end
