class Game < ApplicationRecord
  has_many :frames

  enum status: { started: 0, finished: 1 }

  def current_frame
    frames.find(&:started?)
  end
end
