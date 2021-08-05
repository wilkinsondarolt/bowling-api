class Frame < ApplicationRecord
  belongs_to :game

  validates :number, presence: true

  enum kind: { regular: 0, strike: 1, spare: 2 }
  enum status: { started: 0, finished: 1 }

  default_scope { order(:game_id, :number) }

  def next_delivery
    return :none if finished?
    return :second if first_delivery.present? && second_delivery.blank?
    return :third if first_delivery.present? && second_delivery.present?

    :first
  end
end
