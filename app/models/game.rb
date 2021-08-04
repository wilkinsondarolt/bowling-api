class Game < ApplicationRecord
  has_many :frames

  enum status: { started: 0, finished: 1 }
end
