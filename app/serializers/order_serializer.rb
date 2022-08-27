# frozen_string_literal: true

class OrderSerializer < ActiveModel::Serializer
  attributes :id, :amount, :state, :completed_at

  belongs_to :shopper
  belongs_to :merchant
end
