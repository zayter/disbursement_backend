# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id           :bigint           not null, primary key
#  aasm_state   :string           not null
#  amount       :float            not null
#  completed_at :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  merchant_id  :bigint           not null
#  shopper_id   :bigint           not null
#
# Indexes
#
#  index_orders_on_merchant_id  (merchant_id)
#  index_orders_on_shopper_id   (shopper_id)
#
class Order < ApplicationRecord
  include AASM

  belongs_to :merchant
  belongs_to :shopper

  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }

  alias_attribute :state, :aasm_state

  aasm do
    state :pending, initial: true
    state :completed

    event :complete do
      transitions from: :pending, to: :completed, after: :set_completed_date
    end
  end

  scope :completed_from_to, ->(from, to) { completed.where(completed_at: from..to) }

  def disbursment
    Utilities::Disbursement::Calculate.call(self)
  end

  private

  def set_completed_date
    self.completed_at = Time.zone.now
  end
end
