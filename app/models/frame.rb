class Frame < ApplicationRecord
  belongs_to :game

  validates :number, presence: true

  enum kind: { regular: 0, strike: 1, spare: 2 }
  enum status: { started: 0, finished: 1 }

  default_scope { order(:game_id, :number) }

  def next_delivery
    return :none if finished?

    deliveries = [first_delivery, second_delivery, third_delivery].compact

    case deliveries.size
    when 0 then :first
    when 1 then :second
    when 2 then :third
    else :none
    end
  end

  def last_frame?
    number == 10
  end
end
